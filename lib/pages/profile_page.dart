import 'package:autoshool/ChangeThemeButtonWidget.dart';
import 'package:autoshool/main.dart';
import 'package:autoshool/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autoshool/dark_theme.dart';
import '../auth/login_page.dart';
import '../auth/signup_page.dart';
import '../user_data_page.dart';
import '../about_page.dart';
import '../contact_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.isDarkMode;
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
                    buildProfileToggle(
                    context: context,
                    text: 'Темный режим',
                    isDarkTheme: isDarkTheme,
                    
                    onPressed: () {
                      themeProvider.toggleTheme(!isDarkTheme);
                    },
                    
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context: context,
                    text: 'Личные данные',
                    icon: Icons.person,
                           onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDataPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context: context,
                    text: 'Регистрация',
                    icon: Icons.app_registration,
                           onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context: context,
                    text: 'Войти',
                    icon: Icons.login,
                           onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context: context,
                    text: 'О нас',
                    icon: Icons.info,
                           onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context: context,
                    text: 'Контакты',
                    icon: Icons.contact_mail,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),       
                  const SizedBox(height: 16.0),
                  buildProfileButton(
                    context: context,
                    text: 'Выйти',
                    icon: Icons.exit_to_app,
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
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

  Widget buildProfileButton({
    required BuildContext context,
    required String text,
    IconData? icon,
    Widget? page,
    required Color buttonTextColor,
    required Color iconColor,
    required Color shadowColor,
    required Color backgroundColor,
    void Function()? onPressed,
  }) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              onPressed: onPressed ?? () {},
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
                    style: TextStyle(color: buttonTextColor, fontSize: 16),
                  ),
                  if (icon != null)
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

  Widget buildProfileToggle({
    required BuildContext context,
    required String text,
    IconData? icon,
    required bool isDarkTheme,
    void Function()? onPressed,
    required Color buttonTextColor,
    required Color iconColor,
    required Color shadowColor,
    required Color backgroundColor,
  }) {
    return Container(
      height: 70,
 width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: buttonTextColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: isDarkTheme,
            onChanged: (value) {
              onPressed?.call();
            },
            activeColor: Colors.green,
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
