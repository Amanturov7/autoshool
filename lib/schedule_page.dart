import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    isDarkMode = isDark;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final List<Map<String, dynamic>> _lessons = [
    {
      'id': 1,
      'createdAt': DateTime.now().subtract(Duration(days: 1)),
      'updatedAt': DateTime.now(),
      'name': 'Math Lesson',
      'groupId': 101,
      'lessonType': 1,
      'lessonTypeName': 'Lecture',
      'description': 'Introduction to Algebra',
      'isArchived': false,
      'timeRemain': DateTime.now().add(Duration(days: 1)),
    },
    {
      'id': 2,
      'createdAt': DateTime.now().subtract(Duration(days: 2)),
      'updatedAt': DateTime.now(),
      'name': 'History Lesson',
      'groupId': 102,
      'lessonType': 2,
      'lessonTypeName': 'Discussion',
      'description': 'World War II Overview',
      'isArchived': false,
      'timeRemain': DateTime.now().add(Duration(days: 2)),
    },
  ];

  late List<Appointment> _appointments;
  CalendarView _calendarView = CalendarView.week; // Default to week view

  @override
  void initState() {
    super.initState();
    _appointments = getAppointments();
  }

  List<Appointment> getAppointments() {
    List<Appointment> appointments = <Appointment>[];
    final DateTime today = DateTime.now();

    for (var i = 0; i < _lessons.length; i++) {
      final lesson = _lessons[i];
      final DateTime startTime = DateTime(today.year, today.month, today.day,
          9 + i, 0, 0); // Staggered start times
      final DateTime endTime =
          startTime.add(const Duration(hours: 1)); // Duration of 1 hour

      appointments.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: lesson['name'],
        color: Colors.green,
        recurrenceRule: 'FREQ=DAILY;COUNT=10', // Daily recurrence for 10 days
        isAllDay: false,
      ));
    }

    return appointments;
  }

  void _showLessonDetails(Map<String, dynamic>? lesson) {
    if (lesson == null) {
      // If lesson is null, show a message or handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No details available for this lesson')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity, // Full width
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the left
            children: <Widget>[
              // Add a handle icon to indicate the bottom sheet
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: 80,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Text(
                'ID: ${lesson['id']}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 18.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Created At: ${lesson['createdAt']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Updated At: ${lesson['updatedAt']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Name: ${lesson['name']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Group ID: ${lesson['groupId']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Lesson Type: ${lesson['lessonType']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Lesson Type Name: ${lesson['lessonTypeName']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Description: ${lesson['description']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Is Archived: ${lesson['isArchived']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 8.0),
              Text(
                'Time Remain: ${lesson['timeRemain']}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.0), // Increase font size
                textAlign: TextAlign.left, // Align text to the left
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Allows BottomSheet to be scrollable
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание'),
      ),
      body: SfCalendar(
        view: _calendarView,
        dataSource: MeetingDataSource(_appointments),
        monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showTrailingAndLeadingDates: true,
        ),
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 7, // Start from 7 AM
          endHour: 23, // End at 11 PM, adjust as needed
        ),
        onTap: (details) {
          if (details.appointments?.isNotEmpty ?? false) {
            final appointment = details.appointments!.first as Appointment;
            final lesson = _lessons.firstWhere(
              (lesson) => lesson['name'] == appointment.subject,
            );

            _showLessonDetails(lesson);
          }
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
