import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import '../models/note.dart';
import '../services/note_service.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;
  NoteEditorScreen({this.note});

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final quill.QuillController _quillController = quill.QuillController.basic();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _quillController.document = quill.Document.fromJson(widget.note!.content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                final noteService = Provider.of<NoteService>(context, listen: false);
                if (widget.note == null) {
                  noteService.addNote(Note(
                    title: _titleController.text,
                    content: _quillController.document.toDelta().toJson(),
                  ));
                } else {
                  noteService.updateNote(widget.note!.copyWith(
                    title: _titleController.text,
                    content: _quillController.document.toDelta().toJson(),
                  ));
                }
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: quill.QuillEditor.basic(
                  controller: _quillController,
                  readOnly: false,
                ),
              ),
            ),
            quill.QuillToolbar.basic(controller: _quillController),
          ],
        ),
      ),
    );
  }
}
