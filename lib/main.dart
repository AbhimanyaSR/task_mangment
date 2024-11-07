import 'package:flutter/material.dart';
import 'package:task_mangment/view/note_screen/note_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteListScreen(),
    );
  }
}
