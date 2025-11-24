class Character {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Nome Desconhecido',
      description: json['description'] ?? 'Sem descrição disponível.',
      thumbnailUrl: json['thumbnailUrl'] ?? 'https://via.placeholder.com/150',
    );
  }
}