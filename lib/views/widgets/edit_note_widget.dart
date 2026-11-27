import 'package:flutter/material.dart';
import 'package:notes/cubits/edit_note_cubit.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/helper/app_assests.dart';
import 'package:notes/models/notes.dart';

class EditNoteWidget extends StatelessWidget {
  const EditNoteWidget({
    super.key,
    required this.contentController,
    required this.selectedColor,
    required this.titleController,
    required this.index,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final Color selectedColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.chevron_left,
              size: 30,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),

          Spacer(flex: 1),
          Image(height: 35, width: 35, image: AssetImage(AppAssets.stickyNote)),
          SizedBox(width: 15),
          Text(
            'Edit Note',
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          Spacer(flex: 2),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),

              color: Colors.black.withOpacity(0.4),
            ),

            child: IconButton(
              onPressed: () {
                _editNote(context);
              },
              icon: Icon(Icons.check, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  void _editNote(BuildContext context) {
    final updatedNote = Notes(
      title: titleController.text,
      content: contentController.text,
      color: selectedColor.value,
      date: DateTime.now().toIso8601String(),
    );
    EditNoteCubit.instance.editNote(index: index, updatedNote: updatedNote);
    NotesCubit.instance.fetchAllNotes();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item Edited'), duration: Duration(seconds: 2)),
    );
  }
}
