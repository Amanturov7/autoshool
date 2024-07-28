import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_page.dart';
import '../auth/signup_page.dart';
import '../user_data_page.dart';
import '../home/books_page.dart';
import '../about_page.dart';
import '../contact_page.dart';
import '../pages/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDarkTheme ? Colors.grey[850]! : Colors.white;
    Color buttonTextColor = isDarkTheme ? Colors.white : Colors.black;
    Color iconColor = isDarkTheme ? Colors.white : Colors.black;
    Color shadowColor = isDarkTheme ? Colors.black54 : Colors.grey;
    Color buttonBackgroundColor =
        isDarkTheme ? Colors.grey[800]! : Colors.white;

    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: Text('Error'),
            ),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context,
                    'Личные данные',
                    Icons.person,
                    UserDataPage(),
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context,
                    'Регистрация',
                    Icons.app_registration,
                    SignupPage(),
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context,
                    'Войти',
                    Icons.login,
                    LoginPage(),
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context,
                    'О нас',
                    Icons.info,
                    AboutPage(),
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context,
                    'Контакты',
                    Icons.contact_mail,
                    ContactPage(),
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context,
                    'Выйти',
                    Icons.exit_to_app,
                    null,
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MaterialApp()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildProfileButton(
    BuildContext context,
    String text,
    IconData icon,
    Widget? page, {
    required Color buttonTextColor,
    required Color iconColor,
    required Color shadowColor,
    required Color backgroundColor,
    void Function()? onPressed,
  }) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              onPressed: page != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => page),
                      );
                    }
                  : onPressed,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: buttonTextColor),
                  ),
                  Icon(
                    icon,
                    color: iconColor,
                    size: 35,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }
}
