import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchCars() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/cars/all'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cars');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Машины'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchCars(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var car = snapshot.data![index];
                var name = car['name'] ?? 'Unknown name';
                var model = car['model'] ?? 'Unknown model';
                var imageUrl = car['imageUrl'] ?? 'https://via.placeholder.com/150'; // Placeholder image URL

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
                        children:[ CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                          SizedBox(width: 16), // Adjust spacing between avatar and text
                          Expanded(
                            child: Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ]
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
