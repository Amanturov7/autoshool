import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'terms_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:autoshool/main.dart';
import 'package:autoshool/constants.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _innController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate() && _agreedToTerms) {
      final String apiUrl = '${Constants.baseUrl}/rest/auth/signup';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'login': _loginController.text,
          'password': _passwordController.text,
          'address': _addressController.text,
          'inn': _innController.text,
          'passport': _passportController.text,
          'phone': _phoneController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (route) => false,
        );
      } else {
        // Log the response body for debugging purposes
        print('Response body: ${response.body}');

        // Parse and show error messages
        final responseData = jsonDecode(response.body);
        String errorMessage = '';

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('errors')) {
          final errors = responseData['errors'];
          if (errors is List) {
            for (var error in errors) {
              if (error is Map<String, dynamic> &&
                  error.containsKey('defaultMessage')) {
                errorMessage += '${error['defaultMessage']}\n';
              }
            }
          }
        } else {
          errorMessage = 'An unexpected error occurred.';
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error: ${response.statusCode}'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    Color buttonTextColor =
        isDarkTheme ? Colors.grey : Color.fromARGB(255, 54, 53, 53);
    Color iconColor = isDarkTheme ? Colors.green : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text('register'.tr()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _loginController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите логин';
                    }
                    return null;
                  },
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
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите пароль';
                    } else if (value.length < 8) {
                      return 'Пароль должен содержать не менее 8 символов';
                    } else if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Пароль должен содержать хотя бы одну заглавную букву';
                    }
                    return null;
                  },
                  obscureText: true,
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
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите адрес';
                    }
                    return null;
                  },
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
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _innController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите ИНН';
                    } else if (value.length != 14 ||
                        !RegExp(r'^\d{14}$').hasMatch(value)) {
                      return 'ИНН должен состоять из 14 цифр';
                    }
                    return null;
                  },
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
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passportController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите пасспортные данные';
                    }
                    return null;
                  },
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
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите номер телефона';
                    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Номер телефона должен содержать только цифры';
                    }
                    return null;
                  },
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreedToTerms = value!;
                        });
                      },
                      activeColor: Colors.green,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsPage(),
                            settings: RouteSettings(name: 'TermsPage'),
                          ),
                        );
                      },
                      child: Text(
                        'i_agree'.tr(),
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 70, // Задаем фиксированную высоту для кнопки
                  child: ElevatedButton(
                    onPressed: _agreedToTerms ? _signup : null,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Text(
                        'login_in'.tr(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _agreedToTerms ? iconColor : Colors.grey,
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
      ),
    );
  }
}
