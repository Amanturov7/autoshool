import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:autoshool/constants.dart';

class TicketDetailPage extends StatefulWidget {
  final int ticketNumber;

  const TicketDetailPage({Key? key, required this.ticketNumber}) : super(key: key);

  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  late Future<List<dynamic>> _ticketDetailsFuture;

  @override
  void initState() {
    super.initState();
    _ticketDetailsFuture = _fetchTicketDetails();
  }

  Future<List<dynamic>> _fetchTicketDetails() async {
    final response = await http.get(Uri.parse('${Constants.baseUrl}/rest/tickets/byNumber/${widget.ticketNumber}'));
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return List<dynamic>.from(data);
    } else {
      throw Exception('Failed to load ticket details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket ${widget.ticketNumber} Details'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _ticketDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No details available'));
          } else {
            final details = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: details.length,
              itemBuilder: (BuildContext context, int index) {
                final detail = details[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(detail['question'] ?? 'No question'),
                    subtitle: Text(detail['answer'] ?? 'No answer'),
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
