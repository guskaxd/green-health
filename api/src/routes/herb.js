const express = require('express');
const router = express.Router();
const herbController = require('../controllers/flutterController');

// Rota para obter todas as ervas
router.get('/', herbController.getAllHerbs);

// Rota para obter uma erva por ID
router.get('/:id', herbController.getHerbById);

// Nova rota para pesquisar ervas por problema de saúde
router.get('/search/:problem', herbController.getHerbsByProblem);

module.exports = router;
