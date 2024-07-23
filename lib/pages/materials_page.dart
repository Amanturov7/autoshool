import 'package:autoshool/home/books_page.dart';
import 'package:autoshool/journal/group_page.dart';
import 'package:autoshool/lessons/lesson_page.dart';
import 'package:flutter/material.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({Key? key}) : super(key: key);

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
                  MaterialPageRoute(builder: (context) => const LessonsPage()),
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
                    'Уроки',
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
                  MaterialPageRoute(builder: (context) => BooksPage()),
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
                    'Книги',
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
                  MaterialPageRoute(builder: (context) => const LessonsPage()),
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
                    'Тесты ПДД',
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
                  MaterialPageRoute(builder: (context) => const LessonsPage()),
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
                    'Видеоуроки',
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
        ]
      ),
    );
  }
}
