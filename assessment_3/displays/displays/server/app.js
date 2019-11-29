import path from 'path';
import express from 'express';

const app = express.Router();

// Serve static/public content
app.use('/public', express.static(path.join(__dirname, 'public')));

app.get('/whoami', (req, res) => {
  res.send("You are a winner");
});

module.exports = app;
