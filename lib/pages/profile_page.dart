import 'package:autoshool/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autoshool/dark_theme.dart';
import '../auth/login_page.dart';
import '../auth/signup_page.dart';
import '../user_data_page.dart';
import '../about_page.dart';
import '../contact_page.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Locale? _selectedLocale;


  @override
  Widget build(BuildContext context) {
    _selectedLocale ??= context.locale;
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.isDarkMode;
    Color backgroundColor = isDarkTheme ? Colors.grey[850]! : Colors.white;
    Color buttonTextColor = isDarkTheme ? Colors.white : Colors.black;
    Color iconColor = isDarkTheme ? Colors.white : Colors.black;
    Color shadowColor = isDarkTheme ? Colors.black54 : Colors.grey;
    Color buttonBackgroundColor =
        isDarkTheme ? Colors.grey[800]! : Colors.white;

    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: Text('error'.tr()),
            ),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProfileToggle(
                    context: context,
                    text: 'dark_mode'.tr(),
                    isDarkTheme: isDarkTheme,
                    onPressed: () {
                      themeProvider.toggleTheme(!isDarkTheme);
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  
                  buildDropDown(
                    context: context,
                    icon: Icons.person,

                    onPressed: () {},
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  
                  buildProfileButton(
                    context: context,
                    text: 'my_details'.tr(),
                    icon: Icons.person,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDataPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  
                  buildProfileButton(
                    context: context,
                    text: 'register'.tr(),
                    icon: Icons.app_registration,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  buildProfileButton(
                    context: context,
                    text: 'sign_in'.tr(),
                    icon: Icons.login,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  
                  buildProfileButton(
                    context: context,
                    text: 'about'.tr(),
                    icon: Icons.info,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  
                  buildProfileButton(
                    context: context,
                    text: 'contact'.tr(),
                    icon: Icons.contact_mail,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactPage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                  
                  buildProfileButton(
                    context: context,
                    text: 'log_out'.tr(),
                    icon: Icons.exit_to_app,
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    buttonTextColor: buttonTextColor,
                    iconColor: iconColor,
                    shadowColor: shadowColor,
                    backgroundColor: buttonBackgroundColor,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildProfileButton({
    required BuildContext context,
    required String text,
    IconData? icon,
    Widget? page,
    required Color buttonTextColor,
    required Color iconColor,
    required Color shadowColor,
    required Color backgroundColor,
    void Function()? onPressed,
  }) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: buttonTextColor, fontSize: 16),
            ),
            if (icon != null)
              Icon(
                icon,
                color: iconColor,
                size: 35,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileToggle({
    required BuildContext context,
    required String text,
    IconData? icon,
    required bool isDarkTheme,
    void Function()? onPressed,
    required Color buttonTextColor,
    required Color iconColor,
    required Color shadowColor,
    required Color backgroundColor,
  }) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: buttonTextColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: isDarkTheme,
            onChanged: (value) {
              onPressed?.call();
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
  Widget buildDropDown({
    required BuildContext context,
    IconData? icon,
    void Function()? onPressed,
    required Color buttonTextColor,
    required Color iconColor,
    required Color shadowColor,
    required Color backgroundColor,
  }) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
        Expanded(
          child: DropdownButtonFormField<Locale>(
            value: _selectedLocale, 
            onChanged: (Locale? newValue) {
              setState(() {
                _selectedLocale = newValue!;
                EasyLocalization.of(context)?.setLocale(newValue); 
              });
            },
            items: <Locale>[
              Locale('en', 'US'),
              Locale('ky', 'KG'),
              Locale('ru', 'RU'),
            ].map<DropdownMenuItem<Locale>>((Locale value) {
              return DropdownMenuItem<Locale>(
                
                
                value: value,
                child: 
                   Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        _getLanguageName(value.languageCode),
                        style: TextStyle(
                          fontSize: 16,
                          
                          color: buttonTextColor,
                        ),
                      ),
                    ],
                  ),
            
              );
            }).toList(),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: buttonTextColor),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              filled: true,
              fillColor: backgroundColor,
            ),
            isExpanded: false,
            itemHeight: 60,
            icon: Icon(Icons.arrow_drop_down, color: buttonTextColor, size: 28),
            iconSize: 24,
            style: TextStyle(color: buttonTextColor, fontSize: 16),
            dropdownColor: backgroundColor,
          ),
        ),
        ],
      ),
    );
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'ky':
        return 'Кыргызча';
      case 'ru':
        return 'Русский';
      default:
        return 'Unknown';
    }
  }
}
