import 'package:autoshool/cars/cars_page.dart';
import 'package:autoshool/cars/detailed_view_car_page.dart';
import 'package:autoshool/group/group_page.dart';
import 'package:autoshool/home/books_page.dart';
import 'package:autoshool/lessons/detailed_view_lesson_page.dart';
import 'package:autoshool/lessons/lesson_page.dart';
import 'package:autoshool/schedule_page.dart';
import 'package:autoshool/tests/tests_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    final buttonTextColor = isDarkTheme ? Colors.grey.shade300 : Colors.black87;
    final iconColor = isDarkTheme ? Colors.green : Colors.green;
    final buttonBackgroundColor =
        isDarkTheme ? Colors.grey[800]! : Colors.white;
    final buttonShadowColor = isDarkTheme ? Colors.black54 : Colors.grey;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonBackgroundColor, // Set background color
                foregroundColor: buttonTextColor, // Set text color
                splashFactory: NoSplash.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(double.infinity, 80),
                elevation: 5,
                shadowColor: buttonShadowColor,
              ),
              onPressed: () {},
              icon: Icon(Icons.school, color: iconColor),
              label: Text(
                'study_card'.tr(),
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CarsPage()),
                    );
                  },
                  icon: Image.asset(
                    "assets/images/cars.png",
                    // color: iconColor,
                    width: 45,
                  ),
                  label: Text(
                    'cars'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestsPage()),
                    );
                  },
                  icon: Image.asset(
                    "assets/icons/schedule.png",
                    width: 45,
                  ),
                  label: Text(
                    'schedule'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LessonsPage()),
                    );
                  },
                  icon: Image.asset(
                    "assets/icons/book.png",
                    width: 45,
                  ),
                  label: Text(
                    'lessons'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupsPage()),
                    );
                  },
                  icon: Icon(Icons.groups, color: iconColor, size: 35),
                  label: Text(
                    'groups'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BooksPage()),
                    );
                  },
                  icon: Icon(Icons.book, color: iconColor, size: 35),
                  label: Text(
                    'books'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.video_library, color: iconColor, size: 35),
                  label: Text(
                    'video_lessons'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {},
                  icon:
                      Icon(Icons.currency_bitcoin, color: iconColor, size: 35),
                  label: Text(
                    'puzzles'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackgroundColor, // Set background color
                    foregroundColor: buttonTextColor, // Set text color
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    elevation: 5,
                    shadowColor: buttonShadowColor,
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.assessment, color: iconColor, size: 35),
                  label: Text(
                    'testing'.tr(),
                    style: TextStyle(color: buttonTextColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    ),
  );
}
