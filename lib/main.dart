import 'package:cultural_iq_meter/Pages/GetStart.dart';
import 'package:flutter/material.dart';
import 'Pages/MainMenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.black, // Set the background color of the app
        primarySwatch: Colors.grey,
      ),
      home: GetStart(), 
    );
  }
}