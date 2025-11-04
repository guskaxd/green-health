const express = require('express');
const cors = require('cors'); // CORS habilitado para permitir requisições de outros domínios
const herbRoutes = require('./src/routes/herb'); // Certifique-se de que está importando a rota corretamente

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware para aceitar JSON e habilitar CORS
app.use(cors());
app.use(express.json());

// Usar as rotas das ervas na URL /herbs
app.use('/herbs', herbRoutes);

app.get('/', (req, res) => {
  res.send('API funcionando!');
});

// Iniciar o servidor
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
