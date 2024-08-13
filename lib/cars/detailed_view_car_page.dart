import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:autoshool/dark_theme.dart'; // Import if you have a custom theme provider

class CarDetailPage extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetailPage({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    final backgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    final textColor = isDarkMode ? Colors.grey[300] ?? Colors.grey : Colors.black87;
    final sectionTitleTextColor = isDarkMode ? Colors.grey[400] ?? Colors.grey : Colors.black54;
    final cardBackgroundColor = isDarkMode ? Colors.grey.shade800 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(car['title'] ?? 'No title'), // Handle potential null value
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
            imagePath: car['imageUrl'],
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 16),
          _buildDetailCard(
            title: 'marka'.tr(),
            value: car['name'] ?? 'No name', // Default value for null
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'model'.tr(),
            value: car['model'] ?? 'No model', // Default value for null
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'color'.tr(),
            value: car['color'] ?? 'No color', // Default value for null
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'engine'.tr(),
            value: car['engine']?.toString() ?? 'No engine info', // Convert to string and handle null
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'year'.tr(),
            value: car['year']?.toString() ?? 'No year info', // Convert to string and handle null
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'difficulty_level'.tr(),
            value: car['difficultyLevel']?.toString() ?? 'No difficulty info', // Convert to string and handle null
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'added'.tr(),
            value: car['createdAt'] ?? 'No creation date', // Default value for null
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'updated'.tr(),
            value: car['updatedAt'] ?? 'No update date', // Default value for null
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
      height: 200, // Fixed height for image
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
          width: 2, // Border size
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Corner radius
        child: imagePath != null && imagePath.isNotEmpty
            ? Image.network(
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
