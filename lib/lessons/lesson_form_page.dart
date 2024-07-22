import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:search_page/search_page.dart';

class CreateLessonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Lesson')),
      body: Center(child: Text('Lesson creation form goes here')),
    );
  }
}