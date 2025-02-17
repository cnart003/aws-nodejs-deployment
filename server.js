const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from Caleb Nartey! This Node.js app is running on AWS EKS, deployed with Kubernetes and GitHub Actions. DevOps in action!');
});

app.listen(3000, () => console.log('Server is running on port 3000'));
