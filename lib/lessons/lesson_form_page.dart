import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';

class CreateLessonPage extends StatefulWidget {
  @override
  _CreateLessonPageState createState() => _CreateLessonPageState();
}

class _CreateLessonPageState extends State<CreateLessonPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<dynamic>> _groupsFuture;
  late Future<List<dynamic>> _lessonTypesFuture;

  String _name = '';
  String _description = '';
  int? _groupId;
  int? _lessonType;
  DateTime _timeRemain = DateTime.now();
  bool _isArchived = false;

  List<int> _durations = [1, 3, 7, 14, 30, 60];
  int _selectedDuration = 1;

  @override
  void initState() {
    super.initState();
    _groupsFuture = fetchGroups();
    _lessonTypesFuture = fetchLessonTypes();
  }

  Future<List<dynamic>> fetchGroups() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/groups/all'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) ?? [];
    } else {
      throw Exception('Failed to load groups');
    }
  }

  Future<List<dynamic>> fetchLessonTypes() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/common-reference/by-type/003'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) ?? [];
    } else {
      throw Exception('Failed to load lesson types');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _timeRemain = DateTime.now().add(Duration(days: _selectedDuration));

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/rest/lessons'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _name,
          'description': _description,
          'groupId': _groupId,
          'lessonType': _lessonType,
          'isArchived': _isArchived,
          'timeRemain': _timeRemain.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to create lesson'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Lesson')),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              FutureBuilder<List<dynamic>>(
                future: _groupsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No groups available');
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Group'),
                      items: snapshot.data!
                          .map<DropdownMenuItem<int>>((group) {
                        return DropdownMenuItem<int>(
                          value: group['id'],
                          child: Text(group['name'] ?? 'Unknown group name'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _groupId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a group';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              FutureBuilder<List<dynamic>>(
                future: _lessonTypesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No lesson types available');
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Lesson Type'),
                      items: snapshot.data!
                          .map<DropdownMenuItem<int>>((lessonType) {
                        return DropdownMenuItem<int>(
                          value: lessonType['id'],
                          child: Text(lessonType['title'] ?? 'Unknown lesson type'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _lessonType = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a lesson type';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Time Remain'),
                value: _selectedDuration,
                items: _durations.map<DropdownMenuItem<int>>((int duration) {
                  return DropdownMenuItem<int>(
                    value: duration,
                    child: Text('$duration days'),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    _selectedDuration = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select the remaining time';
                  }
                  return null;
                },
              ),
              // SwitchListTile(
              //   title: Text('Archived'),
              //   value: _isArchived,
              //   onChanged: (bool value) {
              //     setState(() {
              //       _isArchived = value;
              //     });
              //   },
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Create Lesson'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
