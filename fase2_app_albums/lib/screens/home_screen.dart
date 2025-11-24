import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/character_model.dart';
import 'character_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Character> _allCharacters = [];
  List<Character> _filteredCharacters = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
    _searchController.addListener(_filterCharacters);
  }

  Future<void> _fetchCharacters() async {
    try {
      final chars = await _apiService.fetchCharacters();
      setState(() {
        _allCharacters = chars;
        _filteredCharacters = chars;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Erro: $e');
    }
  }

  void _filterCharacters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCharacters = _allCharacters.where((c) {
        return c.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar
      appBar: AppBar(title: const Text("Personagens Marvel")),
      body: Column(
        children: [
          // 2. TextField (Busca)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Semantics(
              label: "Buscar Personagem por Nome",
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: "Buscar por Nome...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          // 3. ListView (Lista de Personagens)
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCharacters.isEmpty
                    ? const Center(child: Text("Nenhum personagem encontrado."))
                    : ListView.builder(
                        itemCount: _filteredCharacters.length,
                        itemBuilder: (context, index) {
                          final character = _filteredCharacters[index];
                          
                          // Acessibilidade e Área de toque
                          return Semantics(
                            label: "Personagem ${character.name}. Toque para ver detalhes.",
                            button: true,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8),
                              // Imagem (Miniatura)
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50), // Redondo opcional
                                child: Image.network(
                                  character.thumbnailUrl,
                                  width: 50, height: 50, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.person),
                                ),
                              ),
                              // Texto (Nome)
                              title: Text(
                                character.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => 
                                      CharacterDetailScreen(character: character),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}