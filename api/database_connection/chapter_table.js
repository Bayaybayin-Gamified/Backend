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
======================================
START OF CHAPTER FUNCTIONS
======================================
*/ 

async function getChapters(){
    const [result] = await connection.query('SELECT * FROM chapter');
    return result[0];
}

async function getChapter(Chapter_ID){
    const [result] = await connection.query(`SELECT * FROM chapter WHERE Chapter_ID = ?`, [Chapter_ID]);
    return result[0];
}

async function addChapter(Chapter_ID, Chapter_Number, Completion_Criteria, Chapter_Description){
    const [result] = await connection.query(
        'INSERT INTO chapter (Chapter_ID, Chapter_Number, Completion_Criteria, Chapter_Description) VALUES (?, ?, ?, ?)',
        [Chapter_ID, Chapter_Number, Completion_Criteria, Chapter_Description]
    );
    const id = result.insertId;
    return getChapter(id);
}

async function updateChapter(Chapter_ID, Chapter_Number, Completion_Criteria, Chapter_Description){
    const [result] = await connection.query(
        'UPDATE chapter SET Chapter_Number = ?, Completion_Criteria = ?, Chapter_Description = ? WHERE Chapter_ID = ?',
        [Chapter_Number, Completion_Criteria, Chapter_Description, Chapter_ID]
    );
    return getChapter(Chapter_ID);
}

async function deleteChapter(Chapter_ID){
    const [result] = await connection.query('DELETE FROM chapter WHERE Chapter_ID = ?', [Chapter_ID]);
    return result;
}

/*
======================================
END OF CHAPTER FUNCTIONS
======================================
*/ 

module.exports = {
  getChapters,
  getChapter,
  addChapter,
  updateChapter,
  deleteChapter
};
