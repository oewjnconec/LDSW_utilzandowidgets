import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido a CineSnap')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenido a CineSnap!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/catalog');
              },
              child: const Text('Entrar como Usuario'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin');
              },
              child: const Text('Administrar Películas'),
            ),
          ],
        ),
      ),
    );
  }
}
