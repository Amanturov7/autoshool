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
        '/register-course':(context) => SignUpPage()
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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Color.fromARGB(255, 104, 103, 103),
            spreadRadius: 0.3
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
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          items: [
    BottomNavigationBarItem(
      activeIcon: Image.asset("assets/icons/home_selected.png", width: 25, height: 25, color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor),
      icon: Image.asset("assets/icons/home.png", width: 25, height: 25, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
      label: 'Главная',
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset("assets/icons/checklist_selected.png", width: 25, height: 25, color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor),
      icon: Image.asset("assets/icons/checklist.png", width: 25, height: 25, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
      label: 'Журнал',
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset("assets/icons/graduate_selected.png", width: 32, height: 32, color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor),
      icon: Image.asset("assets/icons/graduate.png", width: 32, height: 32, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
      label: 'Материалы',
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset("assets/icons/user_selected.png", width: 25, height: 25, color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor),
      icon: Image.asset("assets/icons/user.png", width: 25, height: 25, color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor),
      label: 'Профиль',
    ),
  ],
          ),
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
        tooltip: 'Register for Course',
        child: Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        elevation: 0.0, // Убираем тень (по желанию)
        shape: CircleBorder(), // Задаем круглую форму
      ),
    ),
  );
}
}


// return Scaffold(
//       appBar: AppBar(
//         actions: [
//           ChangeThemeButtonWidget(),
//         ],
//         title: Center(
//           child: RichText(
//             text: TextSpan(
//               text: 'Автошкола ',
//               style: headline1?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: 'Онлайн',
//                   style: headline2?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: _screens[_currentIndex],
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 10,
//               color: Color.fromARGB(255, 104, 103, 103),
//               spreadRadius: 0.3
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Theme(
//             data: Theme.of(context).copyWith(
//               splashFactory: NoSplash.splashFactory,
//               highlightColor: Colors.transparent,
//             ),
//             child: BottomAppBar(
//               shape: CircularNotchedRectangle(),
//               notchMargin: 6.0,
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   IconButton(
//                     icon: Image.asset("assets/icons/home.png", width: 25, height: 25, color: _currentIndex == 0 ? Colors.green : Colors.grey),
//                     onPressed: () {
//                       setState(() {
//                         _currentIndex = 0;
//                       });
//                     },
//                   ),
//                   IconButton(
//                     icon: Image.asset("assets/icons/checklist.png", width: 25, height: 25, color: _currentIndex == 1 ? Colors.green : Colors.grey),
//                     onPressed: () {
//                       setState(() {
//                         _currentIndex = 1;
//                       });
//                     },
//                   ),
//                   SizedBox(width: 48), // The dummy child
//                   IconButton(
//                     icon: Image.asset("assets/icons/graduate.png", width: 32, height: 32, color: _currentIndex == 2 ? Colors.green : Colors.grey),
//                     onPressed: () {
//                       setState(() {
//                         _currentIndex = 2;
//                       });
//                     },
//                   ),
//                   IconButton(
//                     icon: Image.asset("assets/icons/user.png", width: 25, height: 25, color: _currentIndex == 3 ? Colors.green : Colors.grey),
//                     onPressed: () {
//                       setState(() {
//                         _currentIndex = 3;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/register-course');
//         },
//         tooltip: 'Register for Course',
//         child: Icon(Icons.add),
//       ),
//     );