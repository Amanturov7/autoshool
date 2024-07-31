import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelector extends StatefulWidget {
  final Locale? selectedLocale;
  final void Function(Locale?) onChanged;

  LanguageSelector({
    required this.selectedLocale,
    required this.onChanged,
  });

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late Locale _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.selectedLocale ?? Locale('en', 'US'); // Set default locale here
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Locale>(
      value: _selectedLocale,
      onChanged: (Locale? newValue) {
        setState(() {
          _selectedLocale = newValue!;
        });
        widget.onChanged(newValue);
      },
      items: <Locale>[
        Locale('en', 'US'),
        Locale('ky', 'KG'),
        Locale('ru', 'RU'),
      ].map<DropdownMenuItem<Locale>>((Locale value) {
        return DropdownMenuItem<Locale>(
          value: value,
          child: Text(
            _getLanguageName(value.languageCode),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        hintText: 'select_language'.tr(),


      ),
    );
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
