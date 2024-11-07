import 'package:flutter/material.dart';
import 'package:task_mangment/controller/note_screen_controller.dart';
import 'package:task_mangment/model/data_model.dart';
import 'package:task_mangment/view/details_screen/details_screen.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final data = await NoteScreenController.instance.readAll();
    setState(() {
      notes = data;
    });
  }

  void _navigateToDetailScreen([Note? note]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(note: note),
      ),
    );
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            onTap: () => _navigateToDetailScreen(note),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateToDetailScreen(),
      ),
    );
  }
}
