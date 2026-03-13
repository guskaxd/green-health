//Api cloud render.com
import 'dart:convert';
import 'package:http/http.dart' as http;

class HerbService {
  // Função existente: buscar ervas pelo nome
  Future<List<dynamic>> searchHerbByName(String searchText) async {
    var url = Uri.parse('green-health-production.up.railway.app/herbs');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> herbs = json.decode(response.body);

      // Filtra os resultados no cliente para garantir que o termo de pesquisa corresponda ao nome da erva
      List<dynamic> filteredHerbs = herbs.where((herb) {
        var herbName = herb['name'].toString().toLowerCase();
        return herbName.contains(searchText.toLowerCase());
      }).toList();

      return filteredHerbs;
    } else {
      throw Exception('Erro ao buscar ervas');
    }
  }

  // Nova função: buscar ervas pelo problema de saúde
  Future<List<dynamic>> searchHerbByProblem(String problem) async {
    var url = Uri.parse(
        'green-health-production.up.railway.app/herbs/search/$problem'); // URL para busca por problema
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> herbs = json.decode(response.body);
      return herbs; // Retorna a lista de ervas encontradas para o problema
    } else {
      throw Exception(
          'Erro ao buscar ervas para o problema de saúde informado');
    }
  }
}
/*
//Para usar emulador android/ios
import 'dart:convert';
import 'package:http/http.dart' as http;

class HerbService {
  // Função existente: buscar ervas pelo nome
  Future<List<dynamic>> searchHerbByName(String searchText) async {
    var url =
        Uri.parse('http://10.0.2.2:3000/herbs'); // Ajuste a URL da sua API
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> herbs = json.decode(response.body);

      // Filtra os resultados para garantir que o termo de pesquisa corresponda ao nome da erva
      List<dynamic> filteredHerbs = herbs.where((herb) {
        var herbName = herb['name'].toString().toLowerCase();
        return herbName.contains(searchText.toLowerCase());
      }).toList();

      return filteredHerbs;
    } else {
      throw Exception('Erro ao buscar ervas');
    }
  }

  // Nova função: buscar ervas pelo problema de saúde
  Future<List<dynamic>> searchHerbByProblem(String problem) async {
    var url = Uri.parse(
        'http://10.0.2.2:3000/herbs/search/$problem'); // URL para busca por problema
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> herbs = json.decode(response.body);
      return herbs; // Retorna a lista de ervas encontradas para o problema
    } else {
      throw Exception(
          'Erro ao buscar ervas para o problema de saúde informado');
    }
  }
}
*/
