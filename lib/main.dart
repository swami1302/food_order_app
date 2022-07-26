import 'package:flutter/material.dart';

import 'constants.dart';
import 'login_screen.dart';

//f5P5WY1waegr8xxhSwuc0aucQ7Z2

void main() {
  runApp(InitialScreen());
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      title: appName,
      debugShowCheckedModeBanner: false,
    );
  }
}
