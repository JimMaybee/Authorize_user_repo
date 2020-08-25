import 'package:authorize_user/Screens/auth_screen.dart';
import 'package:authorize_user/Screens/image_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Image Manager',
    theme: ThemeData(
      primarySwatch: Colors.green,
      backgroundColor: Colors.lightGreen[600],
      accentColor: Colors.cyanAccent,
      accentColorBrightness: Brightness.dark,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: AuthScreen(),
      ),
    );
  }
}
