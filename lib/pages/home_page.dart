import 'package:autoshool/chat_bot.dart';
import 'package:autoshool/home/books_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    Color buttonTextColor = isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(double.infinity, 80),
              ),
              onPressed: () {},
              icon: Icon(Icons.school, color: buttonTextColor),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.directions_car, color: buttonTextColor),
                  label: Text('Тесты ПДД', style: TextStyle(color: buttonTextColor)),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.schedule, color: buttonTextColor),
                  label: Text('Расписание', style: TextStyle(color: buttonTextColor)),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.book, color: buttonTextColor),
                  label: Text('Уроки', style: TextStyle(color: buttonTextColor)),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ChatPage()), // Переходим на страницу с картой
                  );
                  },
                  icon: Icon(Icons.library_books, color: buttonTextColor),
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
                  ),
                  onPressed: () {
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  BooksPage()));
                  },
                  icon: Icon(Icons.book, color: buttonTextColor),
                  label: Text('Книги', style: TextStyle(color: buttonTextColor)),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.video_library, color: buttonTextColor),
                  label: Text('Видеоуроки', style: TextStyle(color: buttonTextColor)),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.currency_bitcoin, color: buttonTextColor),
                  label: Text('Головоломки', style: TextStyle(color: buttonTextColor)),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(180, 180),
                    maximumSize: Size(180, 180),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.assessment, color: buttonTextColor),
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
