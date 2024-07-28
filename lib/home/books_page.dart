import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:search_page/search_page.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(' BooksPage'),
        shape: Border(
            bottom: BorderSide(
                color: isDarkTheme ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1)),
      ),
      body: Center(child: Text('BooksPage')),
    );
  }
}
