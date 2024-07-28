import 'package:autoshool/about_page.dart';
import 'package:autoshool/registration_course_page.dart';
import 'package:flutter/material.dart';
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
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
        Locale('ky', 'KG')
      ],
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

    precacheImage(AssetImage("assets/icons/home.png"), context);
    precacheImage(AssetImage("assets/icons/home_selected.png"), context);
    precacheImage(AssetImage("assets/icons/checklist.png"), context);
    precacheImage(AssetImage("assets/icons/checklist_selected.png"), context);
    precacheImage(AssetImage("assets/icons/graduate.png"), context);
    precacheImage(AssetImage("assets/icons/graduate_selected.png"), context);
    precacheImage(AssetImage("assets/icons/user.png"), context);
    precacheImage(AssetImage("assets/icons/user_selected.png"), context);

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
        '/register-course': (context) => SignUpPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    JournalPage(),
    MaterialsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final headline1 = Theme.of(context).textTheme.headlineSmall;
    final headline2 = Theme.of(context).textTheme.titleSmall;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    final navColor = isDarkTheme
        ? Color.fromARGB(255, 68, 67, 67).withOpacity(0.1)
        : Colors.grey.withOpacity(0.5);
    final buttonTextColor =
        isDarkTheme ? Colors.grey.shade300 : Color.fromARGB(255, 54, 53, 53);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          ChangeThemeButtonWidget(), // Integrated theme switcher
        ],
        title: Center(
          child: RichText(
            text: TextSpan(
              text: 'Автошкола ',
              style: headline1?.copyWith(
                  fontSize: 24, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: 'Онлайн',
                  style: headline2?.copyWith(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        elevation: 4.0, // Subtle shadow for the app bar
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.1,
              blurRadius: 15,
              offset: Offset(0.1, 0.1),
              color: navColor,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            selectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            showUnselectedLabels: true,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              _bottomNavigationBarItem(
                context,
                "assets/icons/home.png",
                "assets/icons/home_selected.png",
                'Главная',
                25,
                25,
              ),
              _bottomNavigationBarItem(
                context,
                "assets/icons/checklist.png",
                "assets/icons/checklist_selected.png",
                'Журнал',
                25,
                25,
              ),
              _bottomNavigationBarItem(
                context,
                "assets/icons/graduate.png",
                "assets/icons/graduate_selected.png",
                'Материалы',
                32,
                32,
              ),
              _bottomNavigationBarItem(
                context,
                "assets/icons/user.png",
                "assets/icons/user_selected.png",
                'Профиль',
                25,
                25,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 56.0,
        height: 56.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register-course');
          },
          tooltip: 'Подать заявку',
          child: Icon(Icons.add),
          backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
          elevation: 0.0, // Убираем тень (по желанию)
          shape: CircleBorder(), // Задаем круглую форму
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
    BuildContext context,
    String iconPath,
    String activeIconPath,
    String label,
    double width,
    double height,
  ) {
    return BottomNavigationBarItem(
      icon: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Image.asset(
          iconPath,
          width: width,
          height: height,
          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
      activeIcon: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Image.asset(
          activeIconPath,
          width: width,
          height: height,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      label: label,
    );
  }
}
