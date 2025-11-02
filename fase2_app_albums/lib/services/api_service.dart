// lib/services/api_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/album_model.dart'; // Importa os modelos

const String _myJsonServerUser = 'Danielgelsdorf'; 
const String _myJsonServerRepo = 'appFlutterPrimeiroProjeto'; 
const String kMyJsonServerBaseUrl = 'https://my-json-server.typicode.com/$_myJsonServerUser/$_myJsonServerRepo';


class ApiService {
  
  // ------------------------------------------
  // TELA 1: LISTAR USUÁRIOS
  // ------------------------------------------
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$kMyJsonServerBaseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      // Exibe o erro no console e lança uma exceção
      print('Erro ao carregar usuários: ${response.statusCode}');
      throw Exception('Falha ao carregar lista de usuários.');
    }
  }

  // ------------------------------------------
  // TELA 2: LISTAR ÁLBUNS POR USUÁRIO (Filtragem)
  // ------------------------------------------
  Future<List<AlbumDetails>> fetchAlbumsByUserId(int userId) async {
    // O My JSON Server suporta o filtro ?userId={id} nativamente
    final url = '$kMyJsonServerBaseUrl/albums_com_detalhes?userId=$userId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => AlbumDetails.fromMyJsonServer(json)).toList();
    } else {
      print('Erro ao carregar álbuns: ${response.statusCode}');
      throw Exception('Falha ao carregar álbuns para o usuário $userId.');
    }
  }
  
  // ------------------------------------------
  // TELA 3: DETALHES DO ÁLBUM
  // ------------------------------------------
  Future<AlbumDetails> fetchAlbumDetails(int albumId) async {
    final url = '$kMyJsonServerBaseUrl/albums_com_detalhes/$albumId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return AlbumDetails.fromMyJsonServer(jsonMap);
    } else {
      print('Erro ao carregar detalhes: ${response.statusCode}');
      throw Exception('Falha ao carregar detalhes do álbum $albumId.');
    }
  }
}