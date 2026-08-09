import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/widgets/color_pickers.dart';
import 'package:notes/views/widgets/custom_text_field.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  Color selectedColor = const Color(0xFFFFF4B7);

  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          SizedBox(height: 45),

          CustomTextField(
            Controller: titleController,
            text: 'Title',
            maxLength: 20,
            maxLines: 1,
          ),

          SizedBox(height: 15),
          CustomTextField(
            Controller: contentController,
            text: 'Content',
            maxLength: 180,
            maxLines: 4,
          ),
          SizedBox(height: 15),
          ColorPickers(
            onColorSelected: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
          SizedBox(height: 15),

          GestureDetector(
            onTap: () {
              final newNote = Notes(
                color: selectedColor.value,
                content: contentController.text,
                date: DateTime.now().toString(),
                title: titleController.text,
              );
              BlocProvider.of<NotesCubit>(context).addNote(newNote);

              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item added'),
                  duration: Duration(seconds: 2),
                ),
              );
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
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
