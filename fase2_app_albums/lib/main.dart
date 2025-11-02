// lib/main.dart

import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/album_model.dart';
// import 'screens/albums_screen.dart'; // Você criará esta tela depois

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Álbuns Fase 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> _usersFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Inicia a requisição da API
    _usersFuture = _apiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione um Usuário (Tela 1 - Filtro)'),
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostra o loading enquanto espera a resposta da API
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Mostra a mensagem de erro
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Se houver dados, exibe a lista
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.username),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // 🚨 NAVEGAÇÃO PARA A PRÓXIMA TELA (Tela 2)
                    // Você implementará esta navegação quando criar a tela de álbuns
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AlbumsScreen(userId: user.id, userName: user.name),
                    //   ),
                    // );
                    print('Navegar para álbuns do usuário ID: ${user.id}');
                  },
                );
              },
            );
          } else {
            // Se não houver dados
            return const Center(child: Text('Nenhum usuário encontrado.'));
          }
        },
      ),
    );
  }
}