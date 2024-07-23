import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';

class CreateCarPage extends StatefulWidget {
  @override
  _CreateCarPageState createState() => _CreateCarPageState();
}

class _CreateCarPageState extends State<CreateCarPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<dynamic>> _employeeFuture;

  String _name = '';
  String _model = '';
  String _color = '';
  double _engine = 0.0;
  int _year = 0;
  int _difficultyLevel = 0;
  int? _employeeId;

  @override
  void initState() {
    super.initState();
    _employeeFuture = fetchEmployees();
  }

  Future<List<dynamic>> fetchEmployees() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/employees'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) ?? [];
    } else {
      throw Exception('Failed to load employees');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/rest/cars/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _name,
          'model': _model,
          'color': _color,
          'engine': _engine,
          'year': _year,
          'difficultyLevel': _difficultyLevel,
          'employeeId': 1,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to create car'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание машины'),
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
                    return 'Please enter the name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the model';
                  }
                  return null;
                },
                onSaved: (value) {
                  _model = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Color'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the color';
                  }
                  return null;
                },
                onSaved: (value) {
                  _color = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Engine'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the engine capacity';
                  }
                  return null;
                },
                onSaved: (value) {
                  _engine = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  return null;
                },
                onSaved: (value) {
                  _year = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Difficulty Level'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the difficulty level';
                  }
                  return null;
                },
                onSaved: (value) {
                  _difficultyLevel = int.parse(value!);
                },
              ),
              FutureBuilder<List<dynamic>>(
                future: _employeeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No employees available');
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Employee'),
                      items: snapshot.data!
                          .map<DropdownMenuItem<int>>((employee) {
                        return DropdownMenuItem<int>(
                          value: employee['id'],
                          child: Text(employee['name'] ?? 'Unknown employee name'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _employeeId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an employee';
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
                child: Text('Create Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
