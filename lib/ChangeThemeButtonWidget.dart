import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:autoshool/dark_theme.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      width: 100.0, // Adjusted width to fit better within the AppBar
      child: Transform.scale(
        scale: 0.35, // Adjust the scale factor as needed
        child: DayNightSwitch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          },
          sunColor: Colors.yellow[700]!,
          moonColor: Colors.blueGrey[600]!,
          dayColor: Colors.blue[300]!,
          nightColor: Colors.grey[900]!,
          size: Size(40.0, 44.0), // Size of the switch, can be adjusted
        ),
      ),
    );
  }
}
