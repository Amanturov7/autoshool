import 'package:autoshool/tests/tickets_page.dart';
import 'package:autoshool/pages/tests_page.dart';
import 'package:flutter/material.dart';


class Ticket {
  final String title;
  final String description;

  Ticket({required this.title, required this.description});
}

class TestsPage extends StatelessWidget {

  final List<Ticket> tickets = [
    Ticket(title: 'Ticket 1', description: 'Description of Ticket 1'),
    Ticket(title: 'Ticket 2', description: 'Description of Ticket 2'),
    Ticket(title: 'Ticket 3', description: 'Description of Ticket 3'),
    Ticket(title: 'Ticket 4', description: 'Description of Ticket 4'),
    Ticket(title: 'Ticket 5', description: 'Description of Ticket 5'),
    Ticket(title: 'Ticket 6', description: 'Description of Ticket 6'),
    Ticket(title: 'Ticket 7', description: 'Description of Ticket 7'),
    // Ticket(title: 'Ticket 8', description: 'Description of Ticket 8'),
    // Ticket(title: 'Ticket 9', description: 'Description of Ticket 9'),
    // Ticket(title: 'Ticket 10', description: 'Description of Ticket 10'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true, // Allow ListView to wrap its content
        physics: NeverScrollableScrollPhysics(), // Disable scrolling
        itemCount: tickets.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              onTap: () {
                // Handle ticket tap
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.blue),
              ),
              tileColor: Colors.blue,
              title: Center(
                child: Text(
                  tickets[index].title,
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
      ),
    );
  }
}