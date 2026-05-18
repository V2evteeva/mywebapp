const express = require('express');
const { Pool } = require('pg');

const app = express();
app.use(express.json());

const pool = new Pool({
  user: process.env.DB_USER || 'postgres',
  host: process.env.DB_HOST || 'db',
  database: process.env.DB_NAME || 'mywebapp',
  password: process.env.DB_PASSWORD || 'postgres',
  port: process.env.DB_PORT || 5432,
});

// health check
app.get('/health/alive', (req, res) => res.send('OK'));

app.get('/health/ready', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.send('OK');
  } catch {
    res.status(500).send('DB error');
  }
});

// tasks
app.get('/tasks', async (req, res) => {
  const result = await pool.query('SELECT * FROM tasks');
  res.json(result.rows);
});

app.post('/tasks', async (req, res) => {
  const { title } = req.body;
  const result = await pool.query(
    'INSERT INTO tasks(title) VALUES($1) RETURNING *',
    [title]
  );
  res.json(result.rows[0]);
});

app.post('/tasks/:id/done', async (req, res) => {
  const result = await pool.query(
    'UPDATE tasks SET status=\'done\' WHERE id=$1 RETURNING *',
    [req.params.id]
  );
  res.json(result.rows[0]);
});

if (require.main === module) {
  app.listen(3000, () => console.log('Server started on port 3000'));
}

module.exports = app;