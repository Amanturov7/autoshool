import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<List<dynamic>> _groupFuture;
  late Future<List<dynamic>> _employeeFuture;

  String _login = '';
  String _password = '';
  String _name = '';
  String _surname = '';
  String _lastName = '';
  String _email = '';
  String _address = '';
  String _passportSerial = '';
  String _telegram = '';
  String _whatsUp = '';
  int? _phone;
  int? _inn;
  DateTime? _dateOfBirth;
  bool _agree = false;
  int? _groupId;
  int? _employeeId;

  @override
  void initState() {
    super.initState();
    _groupFuture = fetchGroups();
    _employeeFuture = fetchEmployees();
  }

  Future<List<dynamic>> fetchGroups() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/groups/all'));
    final groupsData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return groupsData ?? [];
    } else {
      throw Exception('Failed to load groups data');
    }
  }

  Future<List<dynamic>> fetchEmployees() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/employee/all'));
    final employeesData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return employeesData ?? [];
    } else {
      throw Exception('Failed to load employees data');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/rest/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'login': _login,
          'password': _password,
          'phone': _phone,
          'address': _address,
          'inn': _inn,
          'passportSerial': _passportSerial,
          'email': _email,
          'signupDate': DateTime.now().toIso8601String(),
          'name': _name,
          'surname': _surname,
          'lastName': _lastName,
          'dateOfBirth': _dateOfBirth?.toIso8601String(),
          'telegram': _telegram,
          'whatsUp': _whatsUp,
          'agree': _agree,
          'groupId': _groupId,
          'employeeId': _employeeId,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('user_create_error'.tr()),
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
        title: Text('create_user'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'login'.tr(),
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
                    return 'Please_enter_login'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _login = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'password'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_enter_password'.tr();
                  }
                  if (value.length < 6) {
                    return 'Password_must_be_at_least_6_characters'.tr();
                  }
                  if (!RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).*$').hasMatch(value)) {
                    return 'Password_must_contain_at_least_one_letter_and_one_digit'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'phone_number'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_enter_phone'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = int.tryParse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'address'.tr(),
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
                    return 'Please_enter_address'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'inn'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_enter_inn'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _inn = int.tryParse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'passport_serial'.tr(),
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
                    return 'Please_enter_passport_serial'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _passportSerial = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'email'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_enter_email'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),




              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'surname'.tr(),
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
                    return 'Please_enter_surname'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _surname = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'last_name'.tr(),
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
                    return 'Please_enter_last_name'.tr();
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Telegram',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onSaved: (value) {
                  _telegram = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'WhatsApp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: iconColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onSaved: (value) {
                  _whatsUp = value!;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (value) {
                      setState(() {
                        _agree = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 8.0),
                  Text('i_agree'.tr()),
                ],
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<List<dynamic>>(
                future: _groupFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('no_group_data'.tr());
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        hintText: 'select_group'.tr(),
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
                          child: Text(group['title'] ?? 'Unknown group'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _groupId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please_select_group'.tr();
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<List<dynamic>>(
                future: _employeeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('no_employee_data'.tr());
                  } else {
                    return DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        hintText: 'employee'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: iconColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      items: snapshot.data!
                          .map<DropdownMenuItem<int>>((employee) {
                        return DropdownMenuItem<int>(
                          value: employee['id'],
                          child: Text(employee['name'] ?? 'Unknown employee'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _employeeId = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please_select_employee'.tr();
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 70,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Text(
                      'create_user'.tr(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: iconColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity, 70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

