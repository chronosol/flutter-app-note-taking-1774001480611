import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteService extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get allNotes => List.unmodifiable(_notes);

  final CollectionReference _notesCollection = FirebaseFirestore.instance.collection('notes');

  NoteService() {
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    final snapshot = await _notesCollection.get();
    _notes.clear();
    _notes.addAll(snapshot.docs.map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>)));
    notifyListeners();
  }

  void addNote(Note note) {
    _notesCollection.add(note.toMap());
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    _notesCollection.doc(note.id).update(note.toMap());
    final index = _notes.indexWhere((existingNote) => existingNote.id == note.id);
    if (index >= 0) {
      _notes[index] = note;
      notifyListeners();
    }
  }

  void deleteNote(Note note) {
    _notesCollection.doc(note.id).delete();
    _notes.removeWhere((existingNote) => existingNote.id == note.id);
    notifyListeners();
  }
}
