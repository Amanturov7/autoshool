import 'package:flutter/material.dart';
import 'package:autoshool/pages/home_page.dart';
import 'package:autoshool/pages/journal_page.dart';
import 'package:autoshool/pages/materials_page.dart';
import 'package:autoshool/pages/tests_page.dart';
import 'package:autoshool/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Добавляем цвета для BottomNavigationBar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 48, 187, 48), // Цвет выбранного элемента
          unselectedItemColor: Colors.black54, // Цвет не выбранных элементов
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const JournalPage(),
    const MaterialsPage(),
    const TestsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Журнал',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Материалы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Тесты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
