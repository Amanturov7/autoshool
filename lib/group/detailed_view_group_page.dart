import 'package:autoshool/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupDetailPage extends StatelessWidget {
  final Map<String, dynamic> group = {
    'name': 'Beginner Programming',
    'createdAt': DateTime.now().subtract(Duration(days: 20)).toString(),
    'updatedAt': DateTime.now().subtract(Duration(days: 5)).toString(),
    'image': 'assets/group_image.png', // Моковое изображение
  };

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    final backgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    final textColor =
        isDarkMode ? Colors.grey[300] ?? Colors.grey : Colors.black87;
    final sectionTitleTextColor =
        isDarkMode ? Colors.grey[400] ?? Colors.grey : Colors.black54;
    final cardBackgroundColor =
        isDarkMode ? Colors.grey.shade800 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Group Details'),
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
          _buildImageSection(
            imagePath: group['image'],
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 16),
          _buildDetailCard(
            title: 'Name',
            value: group['name'] ?? 'No name',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Created At',
            value: group['createdAt']?.toString() ?? 'No creation date',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Updated At',
            value: group['updatedAt']?.toString() ?? 'No update date',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection({
    required String? imagePath,
    required bool isDarkMode,
  }) {
    return Container(
      width: double.infinity,
      height: 200, // Фиксированная высота для изображения
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
          width: 2, // Размер бордера
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Радиус углов
        child: imagePath != null && imagePath.isNotEmpty
            ? Image.asset(
                imagePath,
                fit: BoxFit.cover,
              )
            : Center(
                child: Text(
                  'No Photo Available',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[300] : Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
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