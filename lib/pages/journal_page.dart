import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Журнал'),
      ),
      body: Center(
        child: const Text(
          'Это страница журнала',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
