import 'package:autoshool/lessons/lesson_form_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:search_page/search_page.dart';
import 'package:autoshool/constants.dart';

class LessonsPage extends StatefulWidget {
  const LessonsPage({Key? key}) : super(key: key);

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  late Future<List<dynamic>> _lessonsFuture;
  late List<dynamic> _lessons = [];

  @override
  void initState() {
    super.initState();
    _lessonsFuture = fetchLessons();
  }

  Future<List<dynamic>> fetchLessons() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/lessons/all'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Not found');
    }
  }

  void _createLesson() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateLessonPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
         bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
        Color TextColor = isDarkTheme ? Colors.grey : Color.fromARGB(255, 54, 53, 53);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              _lessons = await _lessonsFuture;
              showSearch(
                context: context,
                delegate: SearchPage<dynamic>(
                  items: _lessons,
                  searchLabel: 'Search lessons',
                  suggestion: Center(
                    child: Text('Search lessons by name'),
                  ),
                  failure: Center(
                    child: Text('No results found :('),
                  ),
                  filter: (lesson) => [lesson['name']],
                  builder: (lesson) => Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(lesson['name']),
                      onTap: () {
                        // Actions when item is tapped
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _lessonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var lesson = snapshot.data![index];
                var lessonName = lesson['name'] ?? 'Unknown lesson name';
                var description = lesson['description'] ?? 'No description';

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lessonName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: TextColor)),
                                SizedBox(height: 8),
                                Text(description, style: TextStyle(fontSize: 14, color: TextColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _createLesson();
        },
        label: Text(
          'Create Lesson', style: TextStyle(fontSize: 18, color:Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        icon: const Icon(Icons.group_add, color: Colors.white, size: 25),
      ),
    );
  }
}


