const express = require('express');
const request = require('request');

const app = express();
const port = 3000;

app.get('/github/branches', (req, res) => {
  const repositoryUrl = req.query.url;
  const githubToken = 'votre_token_personnel_github'; // Remplacez par votre token GitHub

  if (!repositoryUrl) {
    return res.status(400).send('URL du dépôt Git manquante');
  }

  const apiUrl = `${repositoryUrl}/branches`;
  
  // En-têtes pour l'authentification GitHub
  const options = {
    url: apiUrl,
    headers: {
      'Authorization': `token ${githubToken}`,
      'Accept': 'application/vnd.github.v3+json',
    },
  };

  request(options, (error, response, body) => {
    if (error) {
      return res.status(500).send(error);
    }
    
    if (response.statusCode === 200) {
      res.json(JSON.parse(body));
    } else {
      res.status(response.statusCode).send(body);
    }
  });
});

app.listen(port, () => {
  console.log(`Proxy server running at http://localhost:${port}`);
});
