import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../widgets/note_list.dart';
import '../services/note_service.dart';
import 'note_editor_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteService(),
      child: Consumer<NoteService>(
        builder: (context, noteService, child) => Scaffold(
          appBar: AppBar(
            title: Text('Notes'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: NoteSearchDelegate(noteService.allNotes),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NoteEditorScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: NoteList(),
        ),
      ),
    );
  }
}

class NoteSearchDelegate extends SearchDelegate {
  final List<Note> notes;
  NoteSearchDelegate(this.notes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = notes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return NoteList(notes: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = notes
        .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return NoteList(notes: results);
  }
}
