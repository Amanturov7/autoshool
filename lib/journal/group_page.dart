import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:search_page/search_page.dart'; // Импортируем search_page

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late Future<List<dynamic>> _groupsFuture;
  late List<dynamic> _groups = []; // Список для хранения загруженных групп

  @override
  void initState() {
    super.initState();
    _groupsFuture = fetchGroups();
  }

  Future<List<dynamic>> fetchGroups() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/groups/all'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Группы'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              _groups = await _groupsFuture; // Загружаем данные групп
              showSearch(
                context: context,
                delegate: SearchPage<dynamic>(
                  items: _groups, // Передаём загруженные группы в items
                  searchLabel: 'Поиск групп',
                  suggestion: Center(
                    child: Text('Поиск групп по названию'),
                  ),
                  failure: Center(
                    child: Text('Нет результатов по вашему запросу :('),
                  ),
                  filter: (group) => [group['name']], // Фильтруем по названию
                  builder: (group) => Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(group['name']),
                      onTap: () {
                        // Действия при выборе элемента
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
        future: _groupsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет данных'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var group = snapshot.data![index];
                var groupName = group['name'] ?? 'Unknown group name';
                var avatarUrl = group['avatarUrl'] ?? 'https://via.placeholder.com/150'; // Placeholder avatar URL

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(avatarUrl),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(groupName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
    );
  }
}
