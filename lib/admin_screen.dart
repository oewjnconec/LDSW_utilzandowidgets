import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final Map<String, String> movieData = {};

    return Scaffold(
      appBar: AppBar(title: const Text('Administrar Películas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Título'),
                    onSaved: (value) => movieData['title'] = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Año'),
                    onSaved: (value) => movieData['year'] = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Director'),
                    onSaved: (value) => movieData['director'] = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Género'),
                    onSaved: (value) => movieData['genre'] = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sinopsis'),
                    onSaved: (value) => movieData['synopsis'] = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'URL Imagen'),
                    onSaved: (value) => movieData['image'] = value!,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FirebaseFirestore.instance.collection('movies').add(movieData);
                      }
                    },
                    child: const Text('Agregar Película'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
