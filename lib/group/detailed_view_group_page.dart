// group_detail_page.dart
import 'package:autoshool/users/user_detailed_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:autoshool/dark_theme.dart';

class GroupDetailPage extends StatelessWidget {
  final Map<String, dynamic> group;

  GroupDetailPage({required this.group});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final backgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    final textColor = isDarkMode ? Colors.grey[300] ?? Colors.grey : Colors.black87;
    final sectionTitleTextColor = isDarkMode ? Colors.grey[400] ?? Colors.grey : Colors.black54;
    final cardBackgroundColor = isDarkMode ? Colors.grey.shade800 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(group['name'] ?? 'No name'),
        elevation: 0,
        shape: Border(
          bottom: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // _buildImageSection(
          //   imagePath: group['image'],
          //   isDarkMode: isDarkMode,
          // ),
          SizedBox(height: 16),
          _buildDetailCard(
            title: 'title'.tr(),
            value: group['name'] ?? 'No name',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'type_study_name'.tr(),
            value: group['typeStudyName']?.toString() ?? 'No type study',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'category'.tr(),
            value: group['categoryName']?.toString() ?? 'No category',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'employee'.tr(),
            value: group['employeeName']?.toString() ?? 'No employee',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'added'.tr(),
            value: group['createdAt']?.toString() ?? 'No creation date',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'updated'.tr(),
            value: group['updatedAt']?.toString() ?? 'No update date',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          SizedBox(height: 16),
         
                          SizedBox(
                  height: 70, // Задаем фиксированную высоту для кнопки
                  child: ElevatedButton(
                     onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDetailPage(
                    group: group,
                    users: List<dynamic>.from(group['usersDto'] ?? []), // Ensure it's a list
                  ),
                ),
              );
            },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.center,
                      
                      child: Text(
                        'students_group'.tr(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 70),
                    ),
                  ),
                )
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
        borderRadius: BorderRadius.circular(12), // Border radius
        child: imagePath != null && imagePath.isNotEmpty
            ? Image.network(
                imagePath, // Changed to Image.network for remote images
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                    'Error loading image',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[300] : Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ),
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
