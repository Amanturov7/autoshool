import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: Center(
        child: const Text(
          'Это главная страница',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
