import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CreateGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание группы'),
      ),
      body: Center(
        child: Text('Form for creating a new group goes here'),
      ),
    );
  }
}