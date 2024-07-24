import 'package:autoshool/chat_bot.dart';
import 'package:autoshool/home/books_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color buttonTextColor = isDarkTheme ? Colors.grey : Color.fromARGB(255, 54, 53, 53);
    Color iconColor = isDarkTheme ? Colors.green : Colors.green;
    Color surfaceTintColor = isDarkTheme ? Colors.green : Colors.green;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(double.infinity, 80),
                surfaceTintColor:surfaceTintColor
              ),
              onPressed: () {},
              icon: Icon(Icons.school, color: iconColor),
              label: Text('Учебная карточка', style: TextStyle(color: buttonTextColor)),
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
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    surfaceTintColor:surfaceTintColor
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.directions_car, color: iconColor, size: 35),
                  label: Text('Тесты ПДД', style: TextStyle(color: buttonTextColor)),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    surfaceTintColor:surfaceTintColor
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.schedule, color: iconColor, size: 35),
                  label: Text('Расписание', style: TextStyle(color: buttonTextColor)),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    surfaceTintColor:surfaceTintColor
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.book, color: iconColor, size: 35),
                  label: Text('Уроки', style: TextStyle(color: buttonTextColor)),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    surfaceTintColor:surfaceTintColor
                  ),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ChatPage()), // Переходим на страницу с картой
                  );
                  },
                  icon: Icon(Icons.library_books, color: iconColor, size: 35),
                  label: Text('Чат Бот', style: TextStyle(color: buttonTextColor)),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    surfaceTintColor:surfaceTintColor 
                  ),
                  onPressed: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  BooksPage()));
                  },
                  icon: Icon(Icons.book, color: iconColor, size: 35),
                  label: Text('Книги', style: TextStyle(color: buttonTextColor)),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    surfaceTintColor:surfaceTintColor 
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.video_library, color: iconColor, size: 35),
                  label: Text('Видеоуроки', style: TextStyle(color: buttonTextColor)),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    surfaceTintColor:surfaceTintColor
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.currency_bitcoin, color: iconColor, size: 35),
                  label: Text('Головоломки', style: TextStyle(color: buttonTextColor)),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                    surfaceTintColor:surfaceTintColor
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.assessment, color: iconColor, size: 35),
                  label: Text('Тестирование', style: TextStyle(color: buttonTextColor)),
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
