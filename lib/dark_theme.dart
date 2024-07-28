import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
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
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.greenAccent),
      titleTextStyle: TextStyle(color: Colors.greenAccent, fontSize: 20),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.green,
      selectionColor: Color.fromARGB(255, 62, 94, 36),
      selectionHandleColor: Colors.green,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.grey),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(color: Colors.grey, fontSize: 20),
      titleSmall: TextStyle(color: Colors.green, fontSize: 16),
      displayLarge: TextStyle(color: Colors.grey[300], fontSize: 16),
      displayMedium: TextStyle(color: Colors.grey[400], fontSize: 14),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.green,
      secondary: Colors.greenAccent,
    ),
    iconTheme: IconThemeData(color: Colors.green, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade800,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.white,
      unselectedIconTheme: IconThemeData(color: Colors.white),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Colors.grey),
      thumbColor: MaterialStateProperty.all(Color.fromARGB(255, 11, 49, 13)),
      trackOutlineColor: MaterialStateProperty.all(Colors.green),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade800,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 243, 241, 241),
    primaryColor: Color.fromARGB(255, 54, 53, 53),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.green),
      titleTextStyle: TextStyle(color: Colors.green, fontSize: 20),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.green,
      selectionColor: Colors.greenAccent,
      selectionHandleColor: Colors.green,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(color: Color.fromARGB(255, 54, 53, 53)),
    ),
    textTheme: TextTheme(
      headlineSmall:
          TextStyle(color: Color.fromARGB(255, 54, 53, 53), fontSize: 20),
      titleSmall: TextStyle(color: Colors.green, fontSize: 16),
      displayLarge: TextStyle(color: Colors.black87, fontSize: 16),
      displayMedium: TextStyle(color: Colors.black54, fontSize: 14),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.greenAccent,
    ),
    iconTheme: IconThemeData(color: Colors.green, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Color.fromARGB(255, 54, 53, 53),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Colors.white),
      thumbColor: MaterialStateProperty.all(Colors.green),
      trackOutlineColor: MaterialStateProperty.all(Colors.green),
      overlayColor: MaterialStateProperty.all(Colors.green.withOpacity(0.1)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
