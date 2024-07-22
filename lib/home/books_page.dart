import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:search_page/search_page.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' BooksPage')),
      body: Center(child: Text('BooksPage')),
    );
  }
}