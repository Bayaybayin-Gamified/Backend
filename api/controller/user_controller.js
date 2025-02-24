const { getUsers, getUser, createUser, updateUser, deleteUser, getUserByEmail } = require('../database_connection/user_table.js');

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// GET ALL USERS
app.get('/users', async (req, res) => {
    const users = await getUsers();
    res.send(users);
});

// GET SINGLE USER
app.get('/users/:id', async (req, res) => {
    const id = req.params.id;
    const user = await getUser(id);
    res.send(user);
});

// CREATE A NEW USER
app.post('/users', async (req, res) => {
    try {
        const { User_ID, Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At } = req.body;
        const existingUser = await getUserByEmail(Email); 
        if (existingUser) {
            return res.status(400).send({ error: 'Email is already in use' });
        }
        const user = await createUser(User_ID, Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At);
        res.send(user);
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});

// UPDATE A USER
app.put('/users/:id', async (req, res) => {
    const id = req.params.id;
    const { Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At } = req.body;
    const user = await updateUser(id, Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At);
    res.send(user);
});

// DELETE A USER
app.delete('/users/:id', async (req, res) => {
    const id = req.params.id;
    await deleteUser(id);
    res.send('User successfully deleted');
});

app.listen(port, () => console.log(`Server is running on port ${port}...`));