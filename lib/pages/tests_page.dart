import 'package:flutter/material.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тесты'),
      ),
      body: Center(
        child: const Text(
          'Это страница тестов',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
