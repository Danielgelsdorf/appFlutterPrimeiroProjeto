import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../models/comic_model.dart';
import '../services/api_service.dart';
import 'comic_detail_screen.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  late Future<List<Comic>> _comicsFuture;

  @override
  void initState() {
    super.initState();
    // Busca os quadrinhos usando o ID do personagem atual
    _comicsFuture = ApiService().fetchComicsByCharacter(widget.character.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar (Título Dinâmico)
      appBar: AppBar (
        title: Text(widget.character.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar', // Isso muda o texto para leitores de tela e mouse
          onPressed: () {
            Navigator.pop(context); // Ação de voltar
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 2. Imagem Principal do Personagem
          Semantics(
            label: "Foto de ${widget.character.name}",
            image: true,
            child: SizedBox(
              height: 250,
              child: Image.network(
                widget.character.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          
          // 3. Título da Seção
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Quadrinhos em que Participa",
              style: Theme.of(context).textTheme.titleLarge, // Fonte grande (WCAG)
            ),
          ),
          
          const SizedBox(height: 10),

          // 4. ListView de Quadrinhos (Horizontal ou Vertical)
          // Aqui faremos vertical para usar o espaço restante
          Expanded(
            child: FutureBuilder<List<Comic>>(
              future: _comicsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Nenhum quadrinho encontrado."));
                }

                final comics = snapshot.data!;
                return ListView.builder(
                  itemCount: comics.length,
                  itemBuilder: (context, index) {
                    final comic = comics[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Semantics(
                        label: "Quadrinho: ${comic.title}. Toque para detalhes.",
                        button: true,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          // Imagem do Quadrinho
                          leading: Image.network(
                            comic.thumbnailUrl,
                            width: 50, fit: BoxFit.cover,
                            errorBuilder: (_,__,___) => const Icon(Icons.book),
                          ),
                          // Título do Quadrinho
                          title: Text(comic.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            // Navegar para Tela 3
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComicDetailScreen(comic: comic),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}