import 'package:autoshool/home/books_page.dart';
import 'package:autoshool/lessons/lesson_page.dart';
import 'package:autoshool/tests/tests_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
                    'lesson'.tr(),
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
                    'books'.tr(),
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
                  MaterialPageRoute(builder: (context) => TestsPage()),
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
                    'tests'.tr(),
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
                    'video_lessons'.tr(),
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
