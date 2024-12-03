import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Películas')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('movies').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data!.docs;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index].data();
              return ListTile(
                leading: Image.network(movie['image'], width: 50),
                title: Text(movie['title']),
                onTap: () {
                  Navigator.pushNamed(context, '/movie_detail', arguments: movie);
                },
              );
            },
          );
        },
      ),
    );
  }
}
