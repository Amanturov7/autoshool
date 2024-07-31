import 'package:autoshool/group/form_group.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:search_page/search_page.dart'; // Import search_page
import 'package:easy_localization/easy_localization.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late Future<List<dynamic>> _groupsFuture;
  late List<dynamic> _groups = []; // List to store loaded groups

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

  void _createGroup() {
    // Implement logic to create a new group
    // For example, navigate to a page where users can create a group
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateGroupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('groups'.tr()),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              _groups = await _groupsFuture; // Load groups data
              showSearch(
                context: context,
                delegate: SearchPage<dynamic>(
                  items: _groups, // Pass loaded groups to items
                  searchLabel: 'search_groups'.tr(),
                  suggestion: Center(
                    child: Text('Search groups by name'),
                  ),
                  failure: Center(
                    child: Text('No results found :('),
                  ),
                  filter: (group) => [group['name']], // Filter by name
                  builder: (group) => Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(group['name']),
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
        future: _groupsFuture,
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
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    _createGroup();
  },
  label: Text(
          'create_group'.tr(),style: TextStyle(fontSize: 18,color: Colors.white),),
  backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        icon: const Icon(Icons.group_add, color: Colors.white, size: 25),

),

    );
  }
}

