import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../services/note_service.dart';
import '../screens/note_editor_screen.dart';

class NoteList extends StatelessWidget {
  final List<Note>? notes;

  NoteList({this.notes});

  @override
  Widget build(BuildContext context) {
    final noteService = Provider.of<NoteService>(context);
    final displayedNotes = notes ?? noteService.allNotes;

    return ListView.builder(
      itemCount: displayedNotes.length,
      itemBuilder: (context, index) {
        final note = displayedNotes[index];
        return ListTile(
          title: Text(note.title),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NoteEditorScreen(note: note),
              ),
            );
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              noteService.deleteNote(note);
            },
          ),
        );
      },
    );
  }
}
