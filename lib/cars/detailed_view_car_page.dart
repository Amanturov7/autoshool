import 'package:autoshool/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetailPage extends StatelessWidget {
  final Map<String, dynamic> car = {
    'name': 'Tesla Model S',
    'model': 'Model S',
    'color': 'Red',
    'engine': 3.2,
    'year': 2022,
    'difficultyLevel': 1,
    'createdAt': DateTime.now().subtract(Duration(days: 30)).toString(),
    'updatedAt': DateTime.now().subtract(Duration(days: 10)).toString(),
    'image': 'assets/images/groups.png', // Моковое изображение
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
        title: Text('Car Details'),
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
            imagePath: car['image'],
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 16),
          _buildDetailCard(
            title: 'Name',
            value: car['name'] ?? 'No name',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Model',
            value: car['model'] ?? 'No model',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Color',
            value: car['color'] ?? 'No color',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Engine',
            value: car['engine']?.toString() ?? 'No engine info',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Year',
            value: car['year']?.toString() ?? 'No year info',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Difficulty Level',
            value: car['difficultyLevel']?.toString() ?? 'No difficulty info',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Created At',
            value: car['createdAt']?.toString() ?? 'No creation date',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Updated At',
            value: car['updatedAt']?.toString() ?? 'No update date',
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
