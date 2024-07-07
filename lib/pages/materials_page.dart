import 'package:flutter/material.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Материалы'),
      ),
      body: Center(
        child: const Text(
          'Это страница материалов',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
