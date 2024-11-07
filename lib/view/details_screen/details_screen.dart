import 'package:flutter/material.dart';
import 'package:task_mangment/controller/note_screen_controller.dart';
import 'package:task_mangment/model/data_model.dart';

class DetailScreen extends StatefulWidget {
  final Note? note;

  DetailScreen({this.note});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  Future<void> _saveNote() async {
    if (widget.note != null) {
      print("Updating note...");
      await NoteScreenController.instance.update(
        Note(
          id: widget.note!.id,
          title: _titleController.text,
          content: _contentController.text,
        ),
      );
    } else {
      print("Creating new note...");
      await NoteScreenController.instance.create(
        Note(
          title: _titleController.text,
          content: _contentController.text,
        ),
      );
    }
    print("Note saved, popping back...");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                if (widget.note != null) {
                  await NoteScreenController.instance.delete(widget.note!.id!);
                }
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Save button pressed");
                _saveNote();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
