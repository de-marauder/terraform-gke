const express = require('express');
const app = express();

app.get('/', (req, res) => {
  const currentTime = new Date().toISOString();
  res.json({ current_time: currentTime });
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
