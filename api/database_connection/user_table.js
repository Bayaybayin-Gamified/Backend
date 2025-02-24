const mysql = require('mysql2');
const dotenv = require('dotenv');

dotenv.config();

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME
}).promise();

/*
================================================
START OF USER FUNCTIONS
================================================
*/
async function getUserByEmail(Email) {
    const [result] = await connection.query(`SELECT * FROM users WHERE Email = ?`, [Email]);
    return result[0];
}

async function getUsers() {
    const [result] = await connection.query('SELECT * FROM users');
    return result;
}

async function getUser(User_ID) {
    const [result] = await connection.query(`SELECT * FROM users WHERE User_ID = ?`, [User_ID]);
    return result[0];
}

async function createUser(User_ID, Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At) {
    const [result] = await connection.query(
        'INSERT INTO users (User_ID, Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [User_ID, Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At]
    );
    const id = result.insertId;
    return getUser(id);
}

async function updateUser(User_ID, Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At) {
    const [result] = await connection.query(
        'UPDATE users SET Email = ?, Password = ?, Authentication_status = ?, Avatar = ?, Ingame_name = ?, in_game_currency = ?, owned_item = ?, OTP_Verification_Status = ?, Created_At = ? WHERE User_ID = ?',
        [Email, Password, Authentication_status, Avatar, Ingame_name, in_game_currency, owned_item, OTP_Verification_Status, Created_At, User_ID]
    );
    return getUser(User_ID);
}

async function deleteUser(User_ID) {
    const [result] = await connection.query('DELETE FROM users WHERE User_ID = ?', [User_ID]);
    return result;
}
/*
================================================
END OF USER FUNCTIONS
================================================
*/

module.exports = {
    getUsers,
    getUser,
    createUser,
    updateUser,
    deleteUser,
    getUserByEmail
};