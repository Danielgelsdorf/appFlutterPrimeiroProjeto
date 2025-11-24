import 'package:flutter/material.dart';
import '../models/comic_model.dart';

class ComicDetailScreen extends StatelessWidget {
  final Comic comic;

  const ComicDetailScreen({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar
      appBar: AppBar(title: const Text("Informações do Quadrinho")),
      
      // 2. SingleChildScrollView para conteúdo longo
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 3. Capa do Quadrinho (Destaque)
            Semantics(
              label: "Capa do quadrinho ${comic.title}",
              image: true,
              child: Container(
                color: Colors.black12,
                height: 300,
                child: Image.network(
                  comic.thumbnailUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 4. Título
                  Text(
                    comic.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // 5. Descrição (Texto longo)
                  Text(
                    "Descrição:",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comic.description,
                    style: const TextStyle(fontSize: 16, height: 1.5), // Altura de linha boa para leitura
                  ),
                  
                  const Divider(height: 30),
                  
                  // 6. Datas de Publicação
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        comic.dates,
                        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}