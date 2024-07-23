import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:autoshool/dark_theme.dart';
import 'package:autoshool/pages/home_page.dart';
import 'package:autoshool/pages/journal_page.dart';
import 'package:autoshool/pages/materials_page.dart';
import 'package:autoshool/pages/tests_page.dart';
import 'package:autoshool/pages/profile_page.dart';
import 'package:autoshool/profile/login_page.dart';
import 'package:autoshool/profile/signin_page.dart';
import 'package:autoshool/pages/settings_page.dart';
import 'package:autoshool/ChangeThemeButtonWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU'), Locale('ky', 'KG')],
      path: 'assets/translations',
      fallbackLocale: Locale('ru', 'RU'),
      startLocale: Locale('ru', 'RU'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
          displayMedium: TextStyle(color: Colors.green),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
          unselectedItemColor: Color.fromARGB(255, 54, 53, 53),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.grey),
          displayMedium: TextStyle(color: Colors.green),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: MyHomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/journal': (context) => JournalPage(),
        '/materials': (context) => MaterialsPage(),
        '/tests': (context) => TestsPage(),
        '/profile': (context) => ProfilePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/settings': (context) => SettingsPage(),
      },
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
    HomePage(),
    JournalPage(),
    MaterialsPage(),
    TestsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';

    final headline1 = Theme.of(context).textTheme.displayLarge;
    final headline2 = Theme.of(context).textTheme.displayMedium;

    return Scaffold(
      appBar: AppBar(
        actions: [
          ChangeThemeButtonWidget(),
        ],
        title: Center(
          child: RichText(
            text: TextSpan(
              text: 'Автошкола ',
              style: headline1?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: 'Онлайн',
                  style: headline2?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
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
