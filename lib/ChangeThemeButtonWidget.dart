import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:autoshool/dark_theme.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      width: 50.0, // Adjusted width to fit better within the AppBar
      child: DayNightSwitch(
        value: themeProvider.isDarkMode, // Required parameter
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        }, // Required parameter
        sunColor: Colors.yellow[700]!, // Customize sun color
        moonColor: Colors.blueGrey[600]!, // Customize moon color
        dayColor: Colors.blue[300]!, // Customize day background color
        nightColor: Colors.grey[900]!, // Customize night background color
        size: Size(40.0, 24.0), // Adjusted size to a more appropriate value
      ),
    );
  }
}
