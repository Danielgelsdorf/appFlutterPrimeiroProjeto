import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character_model.dart';
import '../models/comic_model.dart';

const String _myJsonServerUser = 'Danielgelsdorf'; 
const String _myJsonServerRepo = 'appFlutterPrimeiroProjeto';
const String kBaseUrl = 'https://my-json-server.typicode.com/$_myJsonServerUser/$_myJsonServerRepo';

class ApiService {
  
  // TELA 1: Buscar todos os personagens
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$kBaseUrl/characters'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar personagens.');
    }
  }

  // TELA 2: Buscar quadrinhos de um personagem específico
  Future<List<Comic>> fetchComicsByCharacter(int characterId) async {
    // Filtra no JSON server usando ?characterId=X
    final response = await http.get(Uri.parse('$kBaseUrl/comics?characterId=$characterId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Comic.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar quadrinhos.');
    }
  }
}