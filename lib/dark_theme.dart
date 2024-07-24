import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.grey,
    dropdownMenuTheme: DropdownMenuThemeData(textStyle: TextStyle(color: Colors.grey)),
    textTheme: TextTheme(
      headlineSmall: TextStyle(color: Colors.grey),
      titleSmall: TextStyle(color: Colors.green),
    ),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Color.fromARGB(255, 30, 126, 78), opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 54, 53, 53),
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.white,
      unselectedIconTheme: IconThemeData(color: Colors.white),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Colors.grey),
      thumbColor: MaterialStateProperty.all(Color.fromARGB(255, 11, 49, 13)),
      trackOutlineColor: MaterialStateProperty.all(Colors.green),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 243, 241, 241),
    primaryColor: Color.fromARGB(255, 54, 53, 53),
    textTheme: TextTheme(
      headlineSmall: TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
      titleSmall: TextStyle(color: Colors.green),
    ),
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Color.fromARGB(255, 54, 53, 53),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Colors.white),
      thumbColor: MaterialStateProperty.all(Colors.green),
      trackOutlineColor: MaterialStateProperty.all(Colors.green),
      overlayColor: MaterialStateProperty.all(Colors.green),
    ),
  );
}
