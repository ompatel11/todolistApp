import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/Screens/add_task.dart';
import 'package:todo/Screens/default_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DefaultScreen(),
    routes: {
      '/home': (context) => DefaultScreen(),
      '/new_task': (context) => Add_task(),
    },
    );
  }
}