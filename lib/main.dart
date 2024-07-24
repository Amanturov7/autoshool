import 'dart:ffi';

import 'package:autoshool/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:autoshool/dark_theme.dart'; // Make sure this file has the ThemeProvider and MyThemes class
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
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
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
    // TestsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final headline1 = Theme.of(context).textTheme.headlineSmall;
    final headline2 = Theme.of(context).textTheme.titleSmall;

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
  bottomNavigationBar: Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    height: 60,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color:Colors.grey
          
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Disable animation
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          elevation: 10,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          enableFeedback: false, // Disable ripple effect
          items: [
            BottomNavigationBarItem(
              // icon: Icon(Icons.home),
              activeIcon: Image.asset("assets/icons/home_selected.png",width: 25,color: Colors.green,),
              icon: Image.asset("assets/icons/home.png",width: 25,color: Color(0xFFF434A50)),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/checklist_selected.png",width: 25,color: Colors.green,),
              icon: Image.asset("assets/icons/checklist.png",width: 25,color: Color(0xFFF434A50)),
              // icon: Icon(Icons.book),
              label: 'Журнал',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/graduate_selected.png",width: 32,color: Colors.green,),
              icon: Image.asset("assets/icons/graduate.png",width: 32,color: Color(0xFFF434A50)),
              // icon: Icon(Icons.school),
              label: 'Материалы',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.assignment),
            //   label: 'Тесты',
            // ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.person),
               activeIcon: Image.asset("assets/icons/user_selected.png",width: 25,color: Colors.green,),
              icon: Image.asset("assets/icons/user.png",width: 25,color: Color(0xFFF434A50)),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    ),
  ),
);
  }
}
