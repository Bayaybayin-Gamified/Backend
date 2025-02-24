const { getChapters, getChapter, addChapter, updateChapter, deleteChapter } = require("../database_connection/chapter_table.js")

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// GET ALL CHAPTERS
app.get('/chapters', async (req, res) => {
    const chapters = await getChapters();
    res.send(chapters);
});

//GET A SINGLE CHAPTER
app.get('/chapters/:id', async (req, res) => {
    const id = req.params.id;
    const chapter = await getChapter(id);
    res.send(chapter);
});

// ADD A NEW CHAPTER
app.post('/chapters', async (req, res) => {
    try {
        const { Chapter_ID, Chapter_Number, Completion_Criteria, Chapter_Description } = req.body;
        const chapter = await addChapter(Chapter_ID, Chapter_Number, Completion_Criteria, Chapter_Description);
        res.send(chapter);
    } catch (error) {
        console.error(error);
        res.status(500).send({ error: 'Internal Server Error' });
    }
});

// UPDATE A CHAPTER
app.put('/chapters/:id', async (req, res) => {
    const id = req.params.id;
    const { Chapter_Number, Completion_Criteria, Chapter_Description } = req.body;
    const chapter = await updateChapter(id, Chapter_Number, Completion_Criteria, Chapter_Description);
    res.send(chapter);
});

// DELETE A CHAPTER
app.delete('/chapters/:id', async (req, res) => {
    const id = req.params.id;
    await deleteChapter(id);
    res.send('Chapter successfully deleted');
});

app.listen(port, () => console.log(`Server is running on port ${port}`));