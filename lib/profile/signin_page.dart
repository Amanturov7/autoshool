import 'package:autoshool/auth/terms_page.dart';
import 'package:autoshool/utils/image_selector_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(const MaterialApp(
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  File? _frontPassportImage;
  File? _backPassportImage;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _innController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _educationCategoryController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messengerController = TextEditingController();
  final TextEditingController _preferredTimeController = TextEditingController();
  bool _agreedToTerms = false;

  void _selectFrontPassportImage(File? image) {
    setState(() {
      _frontPassportImage = image;
    });
  }

  void _selectBackPassportImage(File? image) {
    setState(() {
      _backPassportImage = image;
    });
  }

  void _submitForm() {
    // Validate form inputs and submit logic
    // Example validation, adjust as per your requirements
    if (_fullNameController.text.isEmpty ||
        _birthdateController.text.isEmpty ||
        _innController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _educationCategoryController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messengerController.text.isEmpty ||
        _preferredTimeController.text.isEmpty ||
        !_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields and agree to terms')),
      );
      return;
    }

    // Perform signup logic here
    // This is where you would typically send data to a server

    // Print some of the entered data for demonstration
    print('Full Name: ${_fullNameController.text}');
    print('Birthdate: ${_birthdateController.text}');
    print('INN: ${_innController.text}');
    print('Address: ${_addressController.text}');
    print('Location: ${_locationController.text}');
    print('Education Category: ${_educationCategoryController.text}');
    print('Phone Number: ${_phoneNumberController.text}');
    print('Email: ${_emailController.text}');
    print('Messenger: ${_messengerController.text}');
    print('Preferred Time: ${_preferredTimeController.text}');
    print('Agree to Terms: $_agreedToTerms');

    // Navigate to success page or show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup successful')),
    );
  }

  @override
  Widget build(BuildContext context) {
        bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

       Color buttonTextColor = isDarkTheme ? Colors.grey : Color.fromARGB(255, 54, 53, 53);
    Color iconColor = isDarkTheme ? Colors.green : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявка в автошколу'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _fullNameController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(15),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _birthdateController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _innController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _addressController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _locationController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _educationCategoryController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneNumberController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _messengerController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _preferredTimeController,
                              decoration: InputDecoration(
                  hintText: 'login'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                         focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: iconColor), 
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                ),
            ),
            const SizedBox(height: 16.0),
             Text('Front Side of Passport'),
            ImageSelectorBox(
              onSelectImage: _selectFrontPassportImage,
              imageFile: _frontPassportImage,
            ),
            const SizedBox(height: 16.0),
            Text('Back Side of Passport'),
            ImageSelectorBox(
              
              onSelectImage: _selectBackPassportImage,
              imageFile: _backPassportImage,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
             Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreedToTerms = value!;
                        });
                      },
                      
                        activeColor: Colors.green, 
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      
                    ),
                    GestureDetector(
                      onTap: () {
                    
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsPage(),
                            settings: RouteSettings(name: 'TermsPage'),
                          ),
                        );
                      },
                      child: Text(
                        'i_agree'.tr(),
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                
              ],
            ),


             SizedBox(
  height: 70, // Задаем фиксированную высоту для кнопки
  child: ElevatedButton(
    onPressed: _agreedToTerms ? _submitForm : null,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        'login_in'.tr(),
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor:  _agreedToTerms ? iconColor : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minimumSize: Size(double.infinity, 70),
    ),
  ),
             )
             
          ],
        ),
      ),
    );
  }
}