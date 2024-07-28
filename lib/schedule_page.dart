import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late List<Appointment> _appointments;
  Appointment? _selectedEvent;
  DateTime _selectedDate = DateTime.now();
  CalendarView _calendarView = CalendarView.week; // Default to week view

  @override
  void initState() {
    super.initState();
    _appointments = getAppointments();
  }

  List<Appointment> getAppointments() {
    List<Appointment> appointments = <Appointment>[];
    final DateTime today = DateTime.now();

    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    appointments.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Board Meeting',
      color: Colors.blue,
      recurrenceRule: 'FREQ=DAILY;COUNT=10', // Daily recurrence for 10 days
      isAllDay: false,
    ));

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Demo'),
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
          endHour: 23, // End at 6 PM, adjust as needed
        ),
        onTap: (details) {
          if (details.appointments?.isNotEmpty ?? false) {
            setState(() {
              _selectedEvent = details.appointments!.first as Appointment;
            });
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
