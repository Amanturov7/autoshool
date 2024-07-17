import 'dart:ui';
import 'package:autoshool/journal/cars_page.dart';
import 'package:autoshool/journal/group_page.dart';
import 'package:autoshool/journal/user_page.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    'Группы',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
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
                    'Пользователи',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
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
                    'Машины',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
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
