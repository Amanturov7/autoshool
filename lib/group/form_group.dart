import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:easy_localization/easy_localization.dart';

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
          content: Text('group_create_error'.tr()),
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
      appBar: AppBar(
        title: Text('create_group'.tr()),
      ),
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
                    return 'Please_enter_title'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
                            const SizedBox(height: 16.0),

              FutureBuilder<List<dynamic>>(
                future: _typeStudyFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('no_stydy_data'.tr());
                  } else {
                    return DropdownButtonFormField<int>(
                       decoration: InputDecoration(
                  hintText: 'select_type_stydy'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
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
                          return 'Please_select_study'.tr();
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
                            const SizedBox(height: 16.0),

              FutureBuilder<List<dynamic>>(
                future: _categoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('no_category_data'.tr());
                  } else {
                    return DropdownButtonFormField<int>(
                       decoration: InputDecoration(
                  hintText: 'select_category'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
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
                          return 'Please_select_category'.tr();
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
                            const SizedBox(height: 16.0),

    SizedBox(
  height: 70, // Задаем фиксированную высоту для кнопки
  child: ElevatedButton(
    onPressed: _submitForm,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        'create_group'.tr(),
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
