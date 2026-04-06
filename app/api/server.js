const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.json({ message: 'Hello from API Service v1.0 🚀', status: 'healthy', timestamp: new Date().toISOString() });
});

app.get('/health', (req, res) => res.status(200).send('OK'));
app.get('/metrics', (req, res) => {
  // Simple metrics for Prometheus later
  res.json({ requests: Math.floor(Math.random() * 1000) });
});

app.listen(port, () => {
  console.log(`API Service running on http://localhost:${port}`);
});