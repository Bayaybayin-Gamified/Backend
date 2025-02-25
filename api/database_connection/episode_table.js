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
===============================================
START OF EPISODE FUNCTIONS
===============================================
*/

async function getEpisodes() {
    const [result] = await connection.query('SELECT * FROM episode');
    return result;
}

async function getEpisode(Episode_ID) {
    const [result] = await connection.query(`SELECT * FROM episode WHERE Episode_ID = ?`, [Episode_ID]);
    return result[0];
}

async function createEpisode(Episode_ID, Episode_Name, Episode_Number, Episode_Objective, Chapter_ID) {
    const [result] = await connection.query(
        'INSERT INTO episode (Episode_ID, Episode_Name, Episode_Number, Episode_Objective, Chapter_ID) VALUES (?, ?, ?, ?, ?)',
        [Episode_ID, Episode_Name, Episode_Number, Episode_Objective, Chapter_ID]
    );
    const id = result.insertId;
    return getEpisode(id);
}

async function updateEpisode(Episode_ID, Episode_Name, Episode_Number, Episode_Objective, Chapter_ID) {
    const [result] = await connection.query(
        'UPDATE episode SET Episode_Name = ?, Episode_Number = ?, Episode_Objective = ?, Chapter_ID = ? WHERE Episode_ID = ?',
        [Episode_Name, Episode_Number, Episode_Objective, Chapter_ID, Episode_ID]
    );
    return getEpisode(Episode_ID);
}

async function deleteEpisode(Episode_ID) {
    const [result] = await connection.query('DELETE FROM episode WHERE Episode_ID = ?', [Episode_ID]);
    return result;
}

module.exports = {
    getEpisodes,
    getEpisode,
    createEpisode,
    updateEpisode,
    deleteEpisode
};

/*
===============================================
END OF EPISODE FUNCTIONS
===============================================
*/