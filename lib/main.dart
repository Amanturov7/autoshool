import 'package:autoshool/tests/tickets_page.dart';
import 'package:autoshool/profile/login_page.dart';
import 'package:autoshool/profile/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:autoshool/pages/home_page.dart';
import 'package:autoshool/pages/journal_page.dart';
import 'package:autoshool/pages/materials_page.dart';
import 'package:autoshool/pages/tests_page.dart';
import 'package:autoshool/pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkMode = false;

  void _toggleTheme() {
    setState(() {
      // This toggles the darkMode value
      darkMode = !darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

      title: 'AutoSchool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define the default brightness and colors.
        
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        // Define the default font family.
        fontFamily: 'Georgia',
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: const TextTheme(
        //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 48, 187, 48), // Цвет для выбранного элемента
          unselectedItemColor: Colors.black54, // Цвет для невыбранных элементов
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
            color: Colors.black54.withOpacity(0.2), // Установка цвета с прозрачностью
          ),
        ),

      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // Define the default font family.
        fontFamily: 'Georgia',

        // textTheme: const TextTheme(
        //   : TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 48, 187, 48), // Color of the selected item
          unselectedItemColor: Colors.white54, // Color of the unselected items
        ),
      ),
      home:  MyHomePage(toggleTheme: _toggleTheme),
      routes: {
        '/home': (context) => HomePage(),
        '/journal': (context) => JournalPage(),
        '/materials': (context) => MaterialsPage(),
        '/tests': (context) => TestsPage(),
        '/profile': (context) => ProfilePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.toggleTheme}) : super(key: key);

  final VoidCallback toggleTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    JournalPage(),
    MaterialsPage(),
    TestsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoSchool'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
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
