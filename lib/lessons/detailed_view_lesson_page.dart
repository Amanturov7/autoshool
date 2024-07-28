import 'package:autoshool/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedViewLessonPage extends StatelessWidget {
  final Map<String, dynamic> lesson = {
    'name': 'Introduction to Flutter',
    'description': 'A comprehensive introduction to Flutter development.',
    'createdAt': DateTime.now().subtract(Duration(days: 10)).toString(),
    'updatedAt': DateTime.now().subtract(Duration(days: 2)).toString(),
    'timeRemain': '2 hours',
    'lessonTypeName': 'Beginner',
    'isArchived': 'No',
  };

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    final backgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    final textColor =
        isDarkMode ? Colors.grey[300] ?? Colors.grey : Colors.black87;
    final headerTextColor = isDarkMode ? Colors.greenAccent : Colors.green;
    final sectionTitleTextColor =
        isDarkMode ? Colors.grey[400] ?? Colors.grey : Colors.black54;
    final cardBackgroundColor =
        isDarkMode ? Colors.grey.shade800 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Details'),
        elevation: 0,
        shape: Border(
            bottom: BorderSide(
                color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1)),
      ),
      backgroundColor: backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDetailCard(
            title: 'Name',
            value: lesson['name'] ?? 'No name',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Description',
            value: lesson['description'] ?? 'No description',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Created At',
            value: lesson['createdAt']?.toString() ?? 'No creation date',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Updated At',
            value: lesson['updatedAt']?.toString() ?? 'No update date',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Time Remain',
            value: lesson['timeRemain']?.toString() ?? 'No time remain',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Lesson Type',
            value: lesson['lessonTypeName'] ?? 'No lesson type',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Is Archived',
            value: lesson['isArchived'] ?? 'Not archived',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String value,
    required Color textColor,
    required Color sectionTitleTextColor,
    required Color cardBackgroundColor,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: sectionTitleTextColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
