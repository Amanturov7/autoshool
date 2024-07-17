import 'package:autoshool/journal/cars_page.dart';
import 'package:autoshool/journal/group_page.dart';
import 'package:autoshool/journal/user_page.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Журнал'),
      ),
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/groups.jpg'), // Фоновое изображение для раздела "Группы"
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Группы',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black54, // Полупрозрачный фон для текста
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/users.jpg'), // Фоновое изображение для раздела "Пользователи"
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Пользователи',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black54, // Полупрозрачный фон для текста
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cars.jpg'), // Фоновое изображение для раздела "Машины"
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Машины',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black54, // Полупрозрачный фон для текста
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
