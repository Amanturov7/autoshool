import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

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
    Color buttonTextColor =
        isDarkTheme ? Colors.grey : Color.fromARGB(255, 54, 53, 53);
    Color iconColor = isDarkTheme ? Colors.green : Colors.green;
    Color surfaceTintColor = isDarkTheme ? Colors.green : Colors.green;

    return FutureBuilder<bool>(
      
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('error'),
            ),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            body: SingleChildScrollView(
                padding: EdgeInsets.all(10), // Измененные отступы

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
const SizedBox(height: 16.0),
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
    color: Colors.white, // Цвет фона контейнера
    borderRadius: BorderRadius.circular(10.0), // Радиус скругления углов
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Цвет и прозрачность тени
        spreadRadius: 1, // Распространение тени
        blurRadius: 3, // Размытие тени
        offset: Offset(0, 2), // Смещение тени по x и y
      ),
    ],
  ),
                      child: Row(
                        
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          
                          child: TextButton(
                            onPressed: ()async {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserDataPage()),
                        );
                            },
                            style: TextButton.styleFrom(
                              
                              // backgroundColor: Colors.blue, // Цвет фона кнопки
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              
                              // padding: EdgeInsets.all(10),
                            ),
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Личные данные',
                                  style: TextStyle(color:buttonTextColor),
                                ),
                                Icon(
                                  Icons.video_library,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                          
                        ),
                      ],
                    ),
                  ),               
const SizedBox(height: 16.0),                 
 Container(
                    height: 70,
                    width: double.infinity,
                      decoration: BoxDecoration(
    color: Colors.white, // Цвет фона контейнера
    borderRadius: BorderRadius.circular(10.0), // Радиус скругления углов
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Цвет и прозрачность тени
        spreadRadius: 1, // Распространение тени
        blurRadius: 3, // Размытие тени
        offset: Offset(0, 2), // Смещение тени по x и y
      ),
    ],
  ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: ()async {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                            },
                            style: TextButton.styleFrom(
                              // backgroundColor: Colors.blue, // Цвет фона кнопки
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Регистрация',
                                  style: TextStyle(color:buttonTextColor),
                                ),
                                Icon(
                                  Icons.video_library,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),               
                   const SizedBox(height: 16.0),
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
    color: Colors.white, // Цвет фона контейнера
    borderRadius: BorderRadius.circular(10.0), // Радиус скругления углов
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Цвет и прозрачность тени
        spreadRadius: 1, // Распространение тени
        blurRadius: 3, // Размытие тени
        offset: Offset(0, 2), // Смещение тени по x и y
      ),
    ],
  ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: ()async {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                            },
                            style: TextButton.styleFrom(
                              // backgroundColor: Colors.blue, // Цвет фона кнопки
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Войти',
                                  style: TextStyle(color:buttonTextColor),
                                ),
                                Icon(
                                  Icons.video_library,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),               
                    const SizedBox(height: 16.0),
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                    color: Colors.white, // Цвет фона контейнера
                    borderRadius: BorderRadius.circular(10.0), // Радиус скругления углов
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Цвет и прозрачность тени
                        spreadRadius: 1, // Распространение тени
                        blurRadius: 3, // Размытие тени
                        offset: Offset(0, 2), // Смещение тени по x и y
                      ),
                    ],
                  ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: ()async {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutPage()),
                        );
                            },
                            style: TextButton.styleFrom(
                              // backgroundColor: Colors.blue, // Цвет фона кнопки
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'О нас',
                                  style: TextStyle(color:buttonTextColor),
                                ),
                                Icon(
                                  Icons.video_library,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),               
                 const SizedBox(height: 16.0),
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
    color: Colors.white, // Цвет фона контейнера
    borderRadius: BorderRadius.circular(10.0), // Радиус скругления углов
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Цвет и прозрачность тени
        spreadRadius: 1, // Распространение тени
        blurRadius: 3, // Размытие тени
        offset: Offset(0, 2), // Смещение тени по x и y
      ),
    ],
  ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: ()async {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactPage()),
                        );
                            },
                            style: TextButton.styleFrom(
                              // backgroundColor: Colors.blue, // Цвет фона кнопки
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Контакты',
                                  style: TextStyle(color:buttonTextColor),
                                ),
                                Icon(
                                  Icons.video_library,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),               
               const SizedBox(height: 16.0),
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
    color: Colors.white, // Цвет фона контейнера
    borderRadius: BorderRadius.circular(10.0), // Радиус скругления углов
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Цвет и прозрачность тени
        spreadRadius: 1, // Распространение тени
        blurRadius: 3, // Размытие тени
        offset: Offset(0, 2), // Смещение тени по x и y
      ),
    ],
  ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: ()async {
                         final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('token');
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MaterialApp()),
                            (route) => false,
                          );
                            },
                            style: TextButton.styleFrom(
                              // backgroundColor: Colors.blue, // Цвет фона кнопки
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Выйти',
                                  style: TextStyle(color:buttonTextColor),
                                ),
                                Icon(
                                  Icons.video_library,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }
}
