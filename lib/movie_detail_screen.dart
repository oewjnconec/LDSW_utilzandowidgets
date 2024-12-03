import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: Text(movie['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie['image']),
            const SizedBox(height: 16),
            Text('Título: ${movie['title']}', style: const TextStyle(fontSize: 20)),
            Text('Año: ${movie['year']}'),
            Text('Director: ${movie['director']}'),
            Text('Género: ${movie['genre']}'),
            const SizedBox(height: 10),
            Text('Sinopsis: ${movie['synopsis']}'),
          ],
        ),
      ),
    );
  }
}
