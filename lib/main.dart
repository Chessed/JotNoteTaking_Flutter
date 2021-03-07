import 'package:flutter/material.dart';
import './pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        // '/addNote': => AddNote();
        // '/deleteNote': => DeleteNote();
      },
      title: 'Jot Note',
    );
  }
}
