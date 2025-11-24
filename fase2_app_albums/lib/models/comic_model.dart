class Comic {
  final int id;
  final int characterId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String dates;

  Comic({
    required this.id,
    required this.characterId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.dates,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'] ?? 0,
      characterId: json['characterId'] ?? 0,
      title: json['title'] ?? 'Título indisponível',
      description: json['description'] ?? 'Sem descrição detalhada para este quadrinho.',
      thumbnailUrl: json['thumbnailUrl'] ?? 'https://via.placeholder.com/150',
      dates: json['dates'] ?? 'Data desconhecida',
    );
  }
}