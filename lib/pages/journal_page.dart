import 'dart:ui';
import 'package:autoshool/cars/cars_page.dart';
import 'package:autoshool/employee/employee_page.dart';
import 'package:autoshool/group/group_page.dart';
import 'package:autoshool/users/user_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
        Color TextColor = isDarkTheme ? Colors.grey : Colors.white;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GroupsPage()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0), // Добавляем отступы
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0), // Радиус блоков
                  image: DecorationImage(
                    image: AssetImage('assets/images/groups.png'), // Фоновое изображение для раздела "Группы"
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken), // Затемнение
                  ),
                ),
                child: Center(
                  child: Text(
                    'groups'.tr(),
                    style: TextStyle(
                      fontSize: 24,
                      color: TextColor,
                      fontWeight: FontWeight.bold,
                      shadows: [ // Добавление теней к тексту
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UsersPage()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0), // Добавляем отступы
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0), // Радиус блоков
                  image: DecorationImage(
                    image: AssetImage('assets/images/users.png'), // Фоновое изображение для раздела "Пользователи"
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken), // Затемнение
                  ),
                ),
                child: Center(
                  child: Text(
                    'users'.tr(),
                    style: TextStyle(
                      fontSize: 24,
                      color: TextColor,
                      fontWeight: FontWeight.bold,
                      shadows: [ // Добавление теней к тексту
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
                    Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmployeePage()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0), // Добавляем отступы
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0), // Радиус блоков
                  image: DecorationImage(
                    image: AssetImage('assets/images/users.png'), // Фоновое изображение для раздела "Пользователи"
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken), // Затемнение
                  ),
                ),
                child: Center(
                  child: Text(
                    'employee'.tr(),
                    style: TextStyle(
                      fontSize: 24,
                      color: TextColor,
                      fontWeight: FontWeight.bold,
                      shadows: [ // Добавление теней к тексту
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CarsPage()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0), // Добавляем отступы
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0), // Радиус блоков
                  image: DecorationImage(
                    image: AssetImage('assets/images/cars.png'), // Фоновое изображение для раздела "Машины"
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken), // Затемнение
                  ),
                ),
                child: Center(
                  child: Text(
                    'cars'.tr(),
                    style: TextStyle(
                      fontSize: 24,
                      color: TextColor,
                      fontWeight: FontWeight.bold,
                      shadows: [ // Добавление теней к тексту
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
