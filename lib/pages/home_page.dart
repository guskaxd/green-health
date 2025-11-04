import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:saude_verde/services/herb_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _searchResult = '';
  List<dynamic> _herbResults = [];
  final List<String> _recentSearches = [];
  List<dynamic> _favoriteHerbs = []; // Lista para armazenar favoritos
  final HerbService herbService = HerbService();

  bool _isSearchingByProblem = false; // Define o estado de pesquisa

  // Para armazenar o estado de expansão para cada item
  final Map<int, bool> _expandedItems = {};

  final List<Map<String, String>> _defaultMedicinalTrees = [
    {
      'name': 'Aroeira',
      'image': 'lib/assets/aroeira.png',
      'description':
          'Aroeira é uma árvore medicinal com propriedades anti-inflamatórias.',
    },
    {
      'name': 'Alecrim',
      'image': 'lib/assets/alecrim.png',
      'description':
          'Alecrim tem propriedades antimicrobianas, digestivas, calmantes e antidepressivas.',
    },
    {
      'name': 'Boldo',
      'image': 'lib/assets/boldo.png',
      'description':
          'Boldo é usado para o tratamento de problemas digestivos e hepáticos.',
    },
    {
      'name': 'Limoeiro',
      'image': 'lib/assets/limoeiro.png',
      'description':
          'Limoeiro é conhecido por suas frutas ricas em vitamina C.',
    },
    {
      'name': 'Goiabeira',
      'image': 'lib/assets/goiabeira.png',
      'description':
          'Goiabeira oferece frutos ricos em antioxidantes e vitaminas.',
    },
  ];

  final Map<String, String> herbImages = {
    'Aroeira': 'lib/assets/aroeira.png',
    'Limoeiro': 'lib/assets/limoeiro.png',
    'Goiabeira': 'lib/assets/goiabeira.png',
    'Boldo': 'lib/assets/boldo.png',
    'Alecrim': 'lib/assets/alecrim.png',
    'Chá de Limão': 'lib/assets/cha_limao.png',
    'Chá de Hortelã': 'lib/assets/cha_hortela.png',
    'Chá de Camomila': 'lib/assets/cha_camomila.png',
    'Chá de Gengibre': 'lib/assets/cha_gengibre.png',
    'Chá de Cidreira': 'lib/assets/cha_cidreira.png',
    'Chá de Canela': 'lib/assets/cha_canela.png',
  };

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Carregar favoritos no início
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(); // Chama a função de pesquisa
    });
  }

  void _performSearch() async {
    setState(() {
      _searchResult = 'Buscando...';
      _herbResults = [];
    });

    String searchText = _searchController.text.trim();
    if (searchText.isNotEmpty) {
      // Verifica se a pesquisa é sobre um problema de saúde conhecido
      if (_isHealthProblem(searchText)) {
        await _performSearchByProblem(
            searchText); // Busca por problema de saúde
      } else {
        await _performSearchByName(searchText); // Busca por nome de erva
      }
    } else {
      setState(() {
        _herbResults = [];
        _searchResult = 'Por favor, insira um nome ou problema para buscar.';
      });
    }
  }

// Função auxiliar que detecta se a busca é por um problema de saúde
  bool _isHealthProblem(String searchText) {
    // Lista de possíveis problemas de saúde
    const List<String> healthProblems = [
      'diarreia',
      'febre',
      'diabetes',
      'colesterol alto',
      'dor',
      'diarréia',
      'diabétes',
      'dores',
      'diabete',
      'diarreia',
      'dor',
      'dores',
      'cólica',
      'gripes',
      'resfriados',
      'digestão',
      'infecções',
      'gripe',
      'resfriado',
      'digestao',
      'infecoes',
      'infecoes',
      'infecçoes',
      'cabeca',
      'digestão',
      'cólicas',
      'dores de cabeça',
      'infecções respiratórias',
      'digestao',
      'colica',
      'colicas',
      'dor de cabeça',
      'dores de cabeca',
      'infecçoes respiratorias',
      'infecoes respiratorias',
      'infecçao respiratória',
      'infecao respiratoria',
      'respiração',
      'respirar',
      'respiracao',
      'infecoes',
      'infecoes',
      'infecçoes',
      'colicas',
      'colica',
      'gazes',
      'dor de cabeça',
      'mentruação',
      'mesntruacao',
      'cabeça',
      'ansiedade',
      'insônia',
      'digestão',
      'náuseas',
      'insonia',
      'digestao',
      'nauseas',
      'tontura',
      'insônias',
      'insonias',
      'menstruação',
      'menstruacao',
      'dor de garganta',
      'resfriados',
      'digestão',
      'náuseas',
      'dores de garganta',
      'digestao',
      'resfriado',
      'garganta',
      'dor',
      'dores',
      'garganta',
      'digestão',
      'resfriados',
      'cólicas menstruais',
      'digestao',
      'resfriado',
      'colicas menstruais',
      'cólicas',
      'cólica',
      'colicas',
      'colica',
      'ansiedade',
      'estresse',
      'cólicas',
      'gases',
      'dores de cabeça',
      'estresses',
      'cólicas menstruais',
      'colicas menstruais',
      'cólicas',
    ];

    // Verifica se o termo de busca corresponde a algum problema conhecido
    return healthProblems
        .any((problem) => searchText.toLowerCase().contains(problem));
  }

  void _saveRecentSearch(String search) {
    setState(() {
      // Se a pesquisa já existir na lista, remove-a para evitar duplicatas
      _recentSearches.remove(search);

      // Adiciona a pesquisa no início da lista
      _recentSearches.insert(0, search);

      // Limita o número de pesquisas recentes a 3 itens
      if (_recentSearches.length > 3) {
        _recentSearches.removeLast();
      }
    });
  }

  Future<void> _performSearchByName(String searchText) async {
    try {
      var result = await herbService.searchHerbByName(searchText);
      setState(() {
        if (result.isNotEmpty) {
          _herbResults = result;
          _searchResult = '';
          _saveRecentSearch(searchText); // Salvar a pesquisa por nome
        } else {
          _herbResults = [];
          _searchResult = 'Nenhum resultado encontrado.';
        }
      });
    } catch (e) {
      setState(() {
        _searchResult = 'Erro ao buscar dados: $e';
      });
    }
  }

  Future<void> _performSearchByProblem(String problem) async {
    try {
      var result = await herbService.searchHerbByProblem(problem);
      setState(() {
        if (result.isNotEmpty) {
          _herbResults = result;
          _searchResult = '';
          _saveRecentSearch(problem); // Salvar a pesquisa por problema
        } else {
          _herbResults = [];
          _searchResult = 'Nenhum resultado encontrado.';
        }
      });
    } catch (e) {
      setState(() {
        _searchResult = 'Erro ao buscar dados: $e';
      });
    }
  }

  void _resetToHome() {
    setState(() {
      _herbResults = [];
      _searchController.clear();
      _searchResult = '';
    });
  }

  // Método para alternar o estado de expansão para cada item
  void _toggleExpansion(int index) {
    setState(() {
      _expandedItems[index] =
          !_expandedItems.containsKey(index) || !_expandedItems[index]!;
    });
  }

  void _toggleFavorite(dynamic herb) async {
    setState(() {
      if (_favoriteHerbs.contains(herb)) {
        _favoriteHerbs.remove(herb);
      } else {
        _favoriteHerbs.add(herb);
      }
    });
    _saveFavorites();
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteHerbsJson =
        _favoriteHerbs.map((herb) => jsonEncode(herb)).toList();
    await prefs.setStringList('favorites', favoriteHerbsJson);
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteHerbsJson = prefs.getStringList('favorites');
    if (favoriteHerbsJson != null) {
      setState(() {
        _favoriteHerbs =
            favoriteHerbsJson.map((herbJson) => jsonDecode(herbJson)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'lib/assets/icons/logo.jpg',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Saúde Verde',
              style: TextStyle(
                color: Color.fromARGB(204, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 24.0), // Move o ícone mais para a esquerda
            child: IconButton(
              icon: Icon(Icons.info_outline, color: Colors.grey.shade800),
              onPressed: () {
                // Exibe o diálogo com direitos autorais ao clicar no botão de info
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Direitos Autorais',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      content: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Saúde Verde\n',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            TextSpan(
                              text: 'Versão 1.0\n\n',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade600,
                              ),
                            ),
                            TextSpan(
                              text: 'Todos os direitos reservados.\n\n',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: '© 2024 || Guskov Coelho',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // Fecha o diálogo
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de busca com estilo
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade100, // Fundo verde claro
                  borderRadius:
                      BorderRadius.circular(25.0), // Borda arredondada
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26, // Sombra sutil
                      blurRadius: 5,
                      offset: Offset(0, 3), // Sombra abaixo
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black45),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Pesquisar',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          if (_isSearchingByProblem) {
                            _performSearchByProblem(
                                value); // Pesquisa por problema
                          } else {
                            _performSearch(); // Pesquisa por nome
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isSearchingByProblem
                        ? 'Buscar por problema de saúde'
                        : 'Buscar por nome',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade600),
                  ),
                  Switch(
                    value: _isSearchingByProblem,
                    onChanged: (value) {
                      setState(() {
                        _isSearchingByProblem = value;
                      });
                    },
                    activeColor: Colors.green.shade600,
                  ),
                ],
              ),
              */
              // Últimas pesquisas
              if (_recentSearches.isNotEmpty) ...[
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  children: [
                    Icon(Icons.history, color: Colors.green.shade600, size: 30),
                    const SizedBox(width: 8),
                    Text(
                      'Últimas Pesquisas',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade600, // Título verde escuro
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                Wrap(
                  spacing: 11,
                  runSpacing: 4, // Adiciona espaçamento vertical
                  children: _recentSearches.map((search) {
                    return ActionChip(
                      backgroundColor: Colors.white, // Fundo verde suave
                      label: Text(
                        search,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.039,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade600, // Texto verde
                        ),
                      ),
                      elevation: 5, // Sombra suave
                      shadowColor: Colors.green.shade200, // Cor da sombra
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Bordas arredondadas
                        side: const BorderSide(
                          color: Colors.white, // Cor da borda
                          width: 5, // Largura da borda
                        ),
                      ),
                      onPressed: () {
                        _searchController.text = search;
                        if (_isSearchingByProblem) {
                          _performSearchByProblem(search); // Busca por problema
                        } else {
                          _performSearch(); // Busca por nome
                        }
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
              ],

              // Resultados da pesquisa ou mensagem
              if (_herbResults.isNotEmpty)
                _buildSearchResults()
              else if (_searchResult.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    _searchResult,
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.015), // Espaçamento antes do título, 2% da altura da tela
                    Row(
                      children: [
                        Icon(Icons.eco,
                            color: Colors.green.shade600,
                            size: MediaQuery.of(context).size.width *
                                0.08), // Ícone com 8% da largura da tela
                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.02), // Espaçamento entre ícone e texto, 2% da largura da tela
                        Text(
                          'Plantas Medicinais',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.055, // Fonte com 6% da largura da tela
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.02), // Espaçamento após o título, 3% da altura da tela
                    _buildMedicinalTrees(),
                  ],
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade50,
        selectedItemColor:
            Colors.green.shade600, // Cor do ícone selecionado (branco)
        unselectedItemColor: Colors
            .redAccent.shade400, // Cor do ícone não selecionado (verde escuro)
        showSelectedLabels: true, // Mostrar rótulo do item selecionado
        showUnselectedLabels: true, // Mostrar rótulo dos itens não selecionados
        type: BottomNavigationBarType.fixed, // Ícones fixos na barra
        elevation: 8, // Adiciona elevação (sombra) à barra
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade600,
        ),
        onTap: (int index) {
          if (index == 0) {
            _resetToHome();
          } else if (index == 1) {
            _showFavorites(); // Chamando a tela de favoritos
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade600,
                        Colors.green.shade400
                      ], // Gradiente verde moderno
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle, // Ícone circular
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade300
                            .withOpacity(0.6), // Sombra sutil
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: const Offset(0, 3), // Sombra 3D abaixo do ícone
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.home,
                    color: Colors.white,
                    size: 24), // Ícone branco dentro do círculo
              ],
            ),
            label: 'Início', // Rótulo restaurado
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.redAccent.shade400,
                        Colors.pink.shade600
                      ], // Gradiente moderno em vermelho
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle, // Ícone circular
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade300
                            .withOpacity(0.4), // Sombra sutil
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: const Offset(0, 3), // Sombra 3D abaixo do ícone
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.favorite_rounded,
                    color: Colors.white,
                    size: 22), // Ícone branco dentro do círculo
              ],
            ),
            label: 'Favoritos', // Rótulo restaurado
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        Row(
          children: [
            Icon(Icons.list_alt, color: Colors.green.shade600, size: 30),
            const SizedBox(width: 8),
            Text(
              'Resultados das Pesquisas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade600,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.012),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _herbResults.length,
          itemBuilder: (context, index) {
            var herb = _herbResults[index];
            bool isFavorite = _favoriteHerbs.contains(herb);
            bool isExpanded = _expandedItems[index] ?? false;

            // Verifica se o nome da erva está no mapa de imagens e obtém o caminho correspondente
            String imagePath =
                herbImages[herb['name']] ?? 'lib/assets/cha_cidreira.png';

            return Card(
              elevation: 8, // Adiciona uma leve sombra
              margin: const EdgeInsets.symmetric(
                  vertical: 6), // Margem entre os itens
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15), // Bordas arredondadas no card
                side: BorderSide(
                  color: Colors.green.shade50, // Cor da borda
                  width: 2, // Largura da borda
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(10.0), // Espaçamento interno do card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          imagePath,
                          width: 80,
                          height: 78,
                          fit: BoxFit.cover,
                        ), // Substitui o ícone por uma imagem
                        const SizedBox(
                            width: 12), // Espaçamento entre imagem e texto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        4), // Espaço entre o nome e a descrição
                                child: Text(
                                  herb['name'],
                                  style: TextStyle(
                                    fontSize:
                                        14.5, // Aumente o tamanho para destacar o nome
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                        .shade700, // Verde mais escuro para mais contraste
                                    letterSpacing:
                                        0.2, // Espaçamento entre letras para melhorar a leitura
                                  ),
                                ),
                              ),
                              Text(
                                herb['description'],
                                style: TextStyle(
                                  fontSize:
                                      12, // Tamanho ligeiramente menor para a descrição
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                                      .shade800, // Cor mais suave para o texto explicativo
                                  height:
                                      1.2, // Aumenta o espaçamento entre linhas para legibilidade
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.green.shade600,
                              ),
                              onPressed: () {
                                _toggleFavorite(herb);
                              },
                            ),
                            if (herb['preparation'] != null ||
                                herb['details'] != null ||
                                herb['dosage'] != null)
                              IconButton(
                                icon: Icon(
                                  isExpanded ? Icons.remove : Icons.add,
                                  color: Colors.green.shade600,
                                ),
                                onPressed: () {
                                  _toggleExpansion(index);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    if (isExpanded) ...[
                      const SizedBox(
                          height:
                              10), // Espaço adicionado entre a descrição e Posologia
                      if (herb['preparation'] != null)
                        _buildInfoRow(
                          icon: Icons.local_drink,
                          iconColor: Colors.green.shade600,
                          label: 'Preparo:',
                          content: herb['preparation'],
                          contentColor: Colors.grey.shade800,
                        ),
                      if (herb['dosage'] != null)
                        _buildInfoRow(
                          icon: Icons.medical_services,
                          iconColor: Colors.red.shade800,
                          label: 'Posologia:',
                          content: herb['dosage'],
                          contentColor: Colors.grey.shade800,
                        ),
                      if (herb['avoid'] != null) // Verifica se há conteúdo
                        _buildInfoRow(
                          icon: Icons.warning,
                          iconColor: Colors.yellow.shade800,
                          label: 'Evita:',
                          content: herb['avoid'],
                          contentColor: Colors.grey.shade800,
                        ),
                      if (herb['details'] != null)
                        _buildInfoRow(
                          icon: Icons.info,
                          iconColor: Colors.blue.shade800,
                          label: 'Detalhes:',
                          content: herb['details'],
                          contentColor: Colors.grey.shade800,
                        ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String content,
    Color contentColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24), // Tamanho fixo do ícone
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16, // Tamanho de fonte fixo e consistente
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicinalTrees() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _defaultMedicinalTrees.length,
      itemBuilder: (context, index) {
        var tree = _defaultMedicinalTrees[index];
        return GestureDetector(
          onTap: () {
            // Atualiza o texto de busca com o nome da árvore
            _searchController.text = tree['name'] ?? '';
            _performSearch();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(11.5),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.green.shade50,
                width: 1.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    tree['image']!,
                    width: MediaQuery.of(context).size.width *
                        0.225, // Responsivo com base na largura da tela
                    height: MediaQuery.of(context).size.height * 0.11,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tree['name'] ?? 'Sem nome',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tree['description'] ?? 'Descrição indisponível',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.036,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Favoritos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 46, 45, 45),
                )),
            backgroundColor: Colors.green.shade100,
          ),
          body: _favoriteHerbs.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: _favoriteHerbs.length,
                    itemBuilder: (context, index) {
                      var herb = _favoriteHerbs[index];

                      // Define a imagem correspondente ao nome da erva
                      String imageAsset =
                          'lib/assets/alecrim.png'; // Caminho padrão caso não tenha imagem específica
                      if (herb['name'].toLowerCase().contains('aroeira')) {
                        imageAsset = 'lib/assets/aroeira.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('limoeiro')) {
                        imageAsset = 'lib/assets/limoeiro.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('goiabeira')) {
                        imageAsset = 'lib/assets/goiabeira.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('chá de limão')) {
                        imageAsset = 'lib/assets/cha_limao.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('chá de hortelã')) {
                        imageAsset = 'lib/assets/cha_hortela.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('chá de camomila')) {
                        imageAsset = 'lib/assets/cha_camomila.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('chá de gengibre')) {
                        imageAsset = 'lib/assets/cha_gengibre.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('chá de cidreira')) {
                        imageAsset = 'lib/assets/cha_cidreira.png';
                      } else if (herb['name']
                          .toLowerCase()
                          .contains('chá de canela')) {
                        imageAsset = 'lib/assets/cha_canela.png';
                      }

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.green.shade50,
                            width: 3,
                          ),
                        ),
                        elevation: 8, // Adiciona elevação para a sombra
                        shadowColor: Colors.green.shade200.withOpacity(0.4),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5.0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              imageAsset,
                              width: 65,
                              height: 65,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            herb['name'] != null && herb['name'] is String
                                ? herb['name']
                                : 'Sem nome', // Verifique se o nome está disponível
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          subtitle: Text(
                            herb['description'] != null &&
                                    herb['description'] is String
                                ? herb['description']
                                : 'Descrição não disponível', // Verificação de null
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete,
                                size: 30, color: Colors.red),
                            onPressed: () {
                              if (index >= 0 && index < _favoriteHerbs.length) {
                                setState(() {
                                  _favoriteHerbs.removeAt(index);
                                  _saveFavorites();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Item excluído'),
                                    backgroundColor:
                                        Colors.green, // Cor de sucesso
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Erro ao remover o item.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),
                          onTap: () {
                            // Ao clicar no item, atualiza o campo de pesquisa com o nome da erva
                            _searchController.text = herb['name'] ?? '';
                            _performSearch();
                            Navigator.pop(context); // Fecha a tela de favoritos
                          },
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, color: Colors.grey, size: 80),
                      SizedBox(height: 20),
                      Text(
                        'Nenhum favorito adicionado.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
