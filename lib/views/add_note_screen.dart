import 'package:flutter/material.dart';
import 'package:notes/views/widgets/add_note_button.dart';
import 'package:notes/views/widgets/color_pickers_widget.dart';
import 'package:notes/views/widgets/custom_text_field_widget.dart';

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

          AddNoteButton(
            contentController: contentController,
            selectedColor: selectedColor,
            titleController: titleController,
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
