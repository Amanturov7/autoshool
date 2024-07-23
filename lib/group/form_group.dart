import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<dynamic>> _typeStudyFuture;
  late Future<List<dynamic>> _categoryFuture;

  String _name = '';
  int? _typeStudyId;
  int? _categoryId;

  @override
  void initState() {
    super.initState();
    _typeStudyFuture = fetchTypeStudy();
    _categoryFuture = fetchCategory();
  }

  Future<List<dynamic>> fetchTypeStudy() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/common-reference/by-type/004'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) ?? [];
    } else {
      throw Exception('Failed to load type study data');
    }
  }

  Future<List<dynamic>> fetchCategory() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/common-reference/by-type/005'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) ?? [];
    } else {
      throw Exception('Failed to load category data');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/rest/groups'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _name,
          'typeStudyId': _typeStudyId,
          'categoryId': _categoryId,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to create group'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание группы'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              FutureBuilder<List<dynamic>>(
                future: _typeStudyFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No type study data available');
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Type Study'),
                      items: snapshot.data!
                          .map<DropdownMenuItem<int>>((typeStudy) {
                        return DropdownMenuItem<int>(
                          value: typeStudy['id'],
                          child: Text(typeStudy['title'] ?? 'Unknown type study name'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _typeStudyId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a type study';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              FutureBuilder<List<dynamic>>(
                future: _categoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No category data available');
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Category'),
                      items: snapshot.data!
                          .map<DropdownMenuItem<int>>((category) {
                        return DropdownMenuItem<int>(
                          value: category['id'],
                          child: Text(category['title'] ?? 'Unknown category name'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _categoryId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Create Group'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
