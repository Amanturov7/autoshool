import 'package:autoshool/pages/settings_page.dart';
import 'package:autoshool/tests/tickets_page.dart';
import 'package:autoshool/profile/login_page.dart';
import 'package:autoshool/profile/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:autoshool/pages/home_page.dart';
import 'package:autoshool/pages/journal_page.dart';
import 'package:autoshool/pages/materials_page.dart';
import 'package:autoshool/pages/tests_page.dart';
import 'package:autoshool/pages/profile_page.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async  {
    WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU'), Locale('ky', 'KG')],
      path: 'assets/translations',
      fallbackLocale: Locale('ru', 'RU'),
      startLocale: Locale('ru', 'RU'),
    ),
  );
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
      darkMode = !darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        fontFamily: 'Georgia',
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 48, 187, 48),
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
            color: Colors.black54.withOpacity(0.2),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Georgia',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 48, 187, 48),
          unselectedItemColor: Colors.white54,
        ),
      ),
      home: MyHomePage(toggleTheme: _toggleTheme),
      routes: {
        '/home': (context) => HomePage(),
        '/journal': (context) => JournalPage(),
        '/materials': (context) => MaterialsPage(),
        '/tests': (context) => TestsPage(),
        '/profile': (context) => ProfilePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/settings': (context)=> SettingsPage()
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
        title: Center(
          child: RichText(
            text: TextSpan(
              text: 'Автошкола ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Онлайн',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.brightness_6),
          //   onPressed: widget.toggleTheme,
          // ),
                    IconButton(
            icon: Icon(Icons.notifications),
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
