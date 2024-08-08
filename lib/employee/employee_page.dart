
import 'package:autoshool/employee/employee_detail_page.dart';
import 'package:autoshool/employee/form_employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchEmployees() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/employee/all'));
     final employeeData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return employeeData;
    } else {
      throw Exception('Failed to load employee');
    }
  }

  void _createemployee(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateEmployeePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сотрудники'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var employee = snapshot.data![index];
                var fio = employee['name'] ?? 'Unknown fio';
                var avatarUrl = employee['avatarUrl'] ?? 'https://via.placeholder.com/150';

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeDetailPage(
                            employee: employee,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(avatarUrl),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                fio,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          _createemployee(context);
        },
        label:  Text(
          'create_employee'.tr(),
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        icon: const Icon(Icons.person_add, color: Colors.white, size: 25),
      ),
    );
  }
}
