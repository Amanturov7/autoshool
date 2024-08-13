import 'package:autoshool/cars/detailed_view_car_page.dart';
import 'package:autoshool/cars/form_cars_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:search_page/search_page.dart'; // Import the search package

class CarsPage extends StatefulWidget {
  const CarsPage({Key? key}) : super(key: key);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  late Future<List<dynamic>> _carsFuture;
  late List<dynamic> _cars = [];

  @override
  void initState() {
    super.initState();
    _carsFuture = fetchCars();
  }

  Future<List<dynamic>> fetchCars() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/cars/all'));
         final carsData = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return carsData ?? [];
    } else {
      throw Exception('Failed to load groups');
    }
  }

  void _createCar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateCarPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              _cars = await _carsFuture;
              showSearch(
                context: context,
                delegate: SearchPage<dynamic>(
                  items: _cars,
                  searchLabel: 'Search cars',
                  suggestion: const Center(
                    child: Text('Search cars by name'),
                  ),
                  failure: const Center(
                    child: Text('No results found :('),
                  ),
                  filter: (car) => [car['name'] ?? ''],
                  builder: (car) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(car['imageUrl'] ?? 'https://via.placeholder.com/150'),
                      ),
                      title: Text(car['name'] ?? 'Unknown name'),
                      subtitle: Text(car['model'] ?? 'Unknown model'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailPage(car: car),
                          ),
                        );
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
        future: _carsFuture,
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
                var car = snapshot.data![index];
                var name = car['name'] ?? 'Unknown name';
                var model = car['model'] ?? 'Unknown model';
                var imageUrl = car['imageUrl'] ?? 'https://via.placeholder.com/150'; // Placeholder image URL

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailPage(car: car),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                            const SizedBox(width: 16), // Adjust spacing between avatar and text
                            Expanded(
                              child: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        onPressed: _createCar,
        label: Text(
          'create_car'.tr(),
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        icon: const Icon(Icons.local_car_wash, color: Colors.white, size: 25),
      ),
    );
  }
}
