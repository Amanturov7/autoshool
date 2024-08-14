import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';
import 'package:autoshool/tests/tickets_detail_page.dart'; // Import the ticket details page

class TestsPage extends StatefulWidget {
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  late Future<List<int>> _ticketNumbersFuture;

  @override
  void initState() {
    super.initState();
    _ticketNumbersFuture = _fetchTicketNumbers();
  }

  Future<List<int>> _fetchTicketNumbers() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/tickets/uniqueNumbers'));
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      // Convert response to list of integers (ticket numbers)
      return List<int>.from(data);
    } else {
      throw Exception('Failed to load ticket numbers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
      ),
      body: FutureBuilder<List<int>>(
        future: _ticketNumbersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tickets available'));
          } else {
            final ticketNumbers = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: ticketNumbers.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    onTap: () async {
                      // Navigate to the detail page with the ticket number
                      final ticketDetails = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketDetailPage(ticketNumber: ticketNumbers[index]),
                        ),
                      );
                      // Optionally handle the returned data
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.blue),
                    ),
                    tileColor: Colors.blue,
                    title: Center(
                      child: Text(
                        'Ticket ${ticketNumbers[index]}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
