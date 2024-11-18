import 'package:flutter/material.dart';  
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineSnap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CineSnap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<void> addMovie(String title, String description) async {
  await FirebaseFirestore.instance.collection('movies').add({
    'title': title,
    'description': description,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  String pokemonName = '';
  String pokemonImageUrl = '';

  Future<void> fetchPokemonData() async {
    final String apiUrl = 'https://pokeapi.co/api/v2/pokemon/1';  // Pokémon 1: Bulbasaur
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          pokemonName = data['name'];  // Nombre del Pokémon
          pokemonImageUrl = data['sprites']['front_default'];  // Imagen del Pokémon
        });
      } else {
        throw Exception('Error al cargar datos del Pokémon');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Center(
                child: Text(
                  '¡Bienvenido a CineSnap!',
                  style: TextStyle(
                    color: Colors.blue[100], 
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addMovie("Nueva Película", "Descripción de la nueva película");
                },
                child: const Text("Agregar Película"),
              ),
              const SizedBox(height: 40),
              // Mostrar películas desde Firebase
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('movies').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No hay películas disponibles'));
                  }

                  final movies = snapshot.data!.docs.map((doc) {
                    return {
                      'title': doc['title'],
                      'description': doc['description'],
                    };
                  }).toList();

                  return Column(
                    children: movies.map((movie) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[50]?.withOpacity(0.8),
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(movie['description']!),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 40),
              if (pokemonName.isNotEmpty && pokemonImageUrl.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'Pokémon Aleatorio',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue[100],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.network(pokemonImageUrl), 
                    Text(
                      pokemonName[0].toUpperCase() + pokemonName.substring(1),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.blue[100]),
                    ),
                  ],
                )
              else
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ],
      ),
    );
  }
}
