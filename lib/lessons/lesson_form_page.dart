import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:easy_localization/easy_localization.dart';

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
  int _selectedDuration = 60;

  @override
  void initState() {
    super.initState();
    _groupsFuture = fetchGroups();
    _lessonTypesFuture = fetchLessonTypes();
  }

  Future<List<dynamic>> fetchGroups() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/groups/all'));
         final groupsData = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return groupsData ?? [];
    } else {
      throw Exception('Failed to load groups');
    }
  }

  Future<List<dynamic>> fetchLessonTypes() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/common-reference/by-type/003'));
             final lessonTypeData = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return lessonTypeData ?? [];
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
        bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

       Color buttonTextColor = isDarkTheme ? Colors.grey : Color.fromARGB(255, 54, 53, 53);
    Color iconColor = isDarkTheme ? Colors.green : Colors.green;
    return Scaffold(
      appBar: AppBar(title: Text('create_lesson'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'title'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
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
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'description'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 16.0),
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
                      decoration: InputDecoration(
                  hintText: 'groups'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
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
              const SizedBox(height: 16.0),
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
                      decoration: InputDecoration(
                  hintText: 'lesson_type'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
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
              const SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
                value: _selectedDuration,
                items: _durations.map<DropdownMenuItem<int>>((int duration) {
                  return DropdownMenuItem<int>(
                    value: duration,
                    child: Text('$duration '+ 'days'.tr()),
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
    SizedBox(
  height: 70, // Задаем фиксированную высоту для кнопки
  child: ElevatedButton(
    onPressed:  _submitForm ,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        'create_lesson'.tr(),
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor:  iconColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minimumSize: Size(double.infinity, 70),
    ),
  ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
