const HerbModel = require('../models/flutterModels'); // Certifique-se de que o caminho está correto

// Recuperar todas as ervas
const getAllHerbs = (req, res) => {
  const herbs = HerbModel.getAllHerbs();
  res.json(herbs); // Retornar a lista de ervas em formato JSON
};

// Recuperar uma erva pelo ID
const getHerbById = (req, res) => {
  const herbId = parseInt(req.params.id, 10); // Convertendo o ID para inteiro
  const herb = HerbModel.getHerbById(herbId);
  if (herb) {
    res.json(herb); // Retorna a erva encontrada
  } else {
    res.status(404).json({ message: 'Erva não encontrada' }); // Retorna 404 se não encontrar a erva
  }
};

// Recuperar ervas pelo problema de saúde
const getHerbsByProblem = (req, res) => {
  const problem = req.params.problem.toLowerCase(); // Obtém o problema a partir dos parâmetros da URL
  console.log(`Recebido problema de saúde: ${problem}`);
  const herbs = HerbModel.getHerbsByProblem(problem); // Usa o modelo para buscar ervas que tratam o problema
  
  if (herbs.length > 0) {
    console.log(`Ervas encontradas: ${herbs.length}`); // Loga o número de ervas encontradas
    res.status(200).json(herbs);
  } else {
    console.log('Nenhuma erva encontrada para o problema informado');
    res.status(404).json({ message: 'Nenhuma erva encontrada para o problema informado' });
  }
};

module.exports = {
  getAllHerbs,
  getHerbById,
  getHerbsByProblem, // Exportando a nova função
};
