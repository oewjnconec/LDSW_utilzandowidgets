import 'package:flutter/material.dart';

void main() {
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

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> movies = [
    {"title": "Película 1", "description": "Descripción de la película 1"},
    {"title": "Película 2", "description": "Descripción de la película 2"},
    {"title": "Película 3", "description": "Descripción de la película 3"},
  ];

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
                    color: Colors.blue[100], // Color similar a AliceBlue
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...movies.map((movie) => Container(
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
              )).toList(),
            ],
          ),
        ],
      ),
    );
  } 
}
