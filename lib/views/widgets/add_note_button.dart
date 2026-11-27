import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/add_note_cubit.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/models/notes.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    super.key,
    required this.contentController,
    required this.selectedColor,
    required this.titleController,
  });
  final Color selectedColor;

  final TextEditingController titleController;
  final TextEditingController contentController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _addNote(context);
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            'Add Note',

            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }

  void _addNote(BuildContext context) {
    final newNote = Notes(
      color: selectedColor.value,
      content: contentController.text,
      date: DateTime.now().toString(),
      title: titleController.text,
    );
    AddNoteCubit.instance.addNote(newNote);
    NotesCubit.instance.fetchAllNotes();

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item added'), duration: Duration(seconds: 2)),
    );
  }
}
