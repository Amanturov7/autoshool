import 'package:autoshool/utils/image_selector_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  bool _agreeToTerms = false;

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
        !_agreeToTerms) {
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
    print('Agree to Terms: $_agreeToTerms');

    // Navigate to success page or show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup successful')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _birthdateController,
              decoration: const InputDecoration(labelText: 'Birthdate'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _innController,
              decoration: const InputDecoration(labelText: 'INN'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _educationCategoryController,
              decoration: const InputDecoration(labelText: 'Education Category'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _messengerController,
              decoration: const InputDecoration(labelText: 'Messenger (WhatsApp/Telegram)'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _preferredTimeController,
              decoration: const InputDecoration(labelText: 'Preferred Time for Lessons'),
            ),
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
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                ),
                Text('I agree to the terms and conditions'),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}