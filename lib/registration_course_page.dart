import 'package:flutter/material.dart';

class RegisterCoursePage extends StatelessWidget {
  const RegisterCoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация на курс'),
      ),
      body: Center(
        child: Text('Здесь будет форма регистрации на курс.'),
      ),
    );
  }
}
