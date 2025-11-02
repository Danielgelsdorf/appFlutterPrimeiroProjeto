// lib/models/album_model.dart

import 'dart:convert';

// Modelo para o Usuário
class User {
  final int id;
  final String name;
  final String username;

  User({required this.id, required this.name, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Usuário Desconhecido',
      username: json['username'] ?? '',
    );
  }
}

// Modelo de Detalhes do Álbum (Lista e Detalhe)
class AlbumDetails {
  final int id;
  final int userId;
  final String title;
  final String description; 
  final List<String> imageUrls; // Lista de URLs de imagens

  AlbumDetails({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.imageUrls,
  });

  factory AlbumDetails.fromMyJsonServer(Map<String, dynamic> json) {
    // Converte a lista dinâmica para List<String>
    final List<dynamic> urls = json['imageUrls'] ?? [];
    
    return AlbumDetails(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? 'Sem Título',
      description: json['description'] ?? 'Sem descrição detalhada.',
      imageUrls: urls.map((url) => url.toString()).toList(),
    );
  }
}