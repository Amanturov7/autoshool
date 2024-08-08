import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:autoshool/dark_theme.dart';

class EmployeeDetailPage extends StatelessWidget {
  final Map<String, dynamic> employee;

  EmployeeDetailPage({required this.employee});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    final backgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    final textColor = isDarkMode ? Colors.grey[300] ?? Colors.grey : Colors.black87;
    final sectionTitleTextColor = isDarkMode ? Colors.grey[400] ?? Colors.grey : Colors.black54;
    final cardBackgroundColor = isDarkMode ? Colors.grey.shade800 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('${employee['name']} ${employee['surname']}'), // Displaying employee's name
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
          _buildImageSection(
            imagePath: employee['avatarUrl'],
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: 16),
          _buildDetailCard(
            title: 'employeename'.tr(),
            value: employee['name'] ?? 'No employeename',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Email'.tr(),
            value: employee['email'] ?? 'No email',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'address'.tr(),
            value: employee['address'] ?? 'No address',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'phone'.tr(),
            value: (employee['phone'] ?? 'No phone').toString(), // Ensure value is a string
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'surname'.tr(),
            value: employee['surname'] ?? 'No surname',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'last_name'.tr(),
            value: employee['lastName'] ?? 'No last name',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'birthday'.tr(),
            value: employee['dateOfBirth'] ?? 'No date of birth',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'Telegram'.tr(),
            value: employee['telegram'] ?? 'No telegram',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'WhatsUp'.tr(),
            value: employee['whatsUp'] ?? 'No WhatsUp',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          _buildDetailCard(
            title: 'group'.tr(),
            value: employee['groupName'] ?? 'No group name',
            textColor: textColor,
            sectionTitleTextColor: sectionTitleTextColor,
            cardBackgroundColor: cardBackgroundColor,
          ),
          // Add more details as needed
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
      height: 200,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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
