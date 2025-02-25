const { getEpisodes, getEpisode, createEpisode, updateEpisode, deleteEpisode } = require('../database_connection/episode_table');

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// GET ALL EPISODES
app.get('/episodes', async (req, res) => {
    const episodes = await getEpisodes();
    res.send(episodes);
});

// GET SINGLE EPISODE
app.get('/episodes/:id', async (req, res) => {
    const id = req.params.id;
    const episode = await getEpisode(id);
    res.send(episode);
});

// CREATE A NEW EPISODE
app.post('/episodes', async (req, res) => {
    const { Episode_ID, Episode_Name, Episode_Number, Episode_Objective, Chapter_ID } = req.body;
    const episode = await createEpisode(Episode_ID, Episode_Name, Episode_Number, Episode_Objective, Chapter_ID);
    res.send(episode);
});

// UPDATE AN EPISODE
app.put('/episodes/:id', async (req, res) => {
    const id = req.params.id;
    const { Episode_Name, Episode_Number, Episode_Objective, Chapter_ID } = req.body;
    const episode = await updateEpisode(id, Episode_Name, Episode_Number, Episode_Objective, Chapter_ID);
    res.send(episode);
});

// DELETE AN EPISODE
app.delete('/episodes/:id', async (req, res) => {
    const id = req.params.id;
    await deleteEpisode(id);
    res.send('Episode successfully deleted');
});

app.listen(port, () => console.log(`Server is running on port ${port}...`));