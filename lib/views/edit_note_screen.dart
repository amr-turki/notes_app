import 'package:flutter/material.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/widgets/color_pickers_widget.dart';
import 'package:notes/views/widgets/custom_text_field_widget.dart';
import 'package:notes/views/widgets/edit_note_widget.dart';

class EditNote extends StatefulWidget {
  const EditNote({
    super.key,
    required this.changeTheme,
    required this.note,
    required this.index,
  });
  final Function(ThemeMode) changeTheme;
  final Notes note;
  final int index;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
    selectedColor = Color(widget.note.color);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 25),
          EditNoteWidget(
            contentController: contentController,
            titleController: titleController,
            selectedColor: selectedColor,
            index: widget.index,
          ),

          SizedBox(height: 65),
          CustomTextField(
            Controller: titleController,
            text: widget.note.title,
            maxLength: 20,
            maxLines: 1,
          ),

          SizedBox(height: 30),
          CustomTextField(
            Controller: contentController,
            text: widget.note.content,
            maxLength: 180,
            maxLines: 4,
          ),

          SizedBox(height: 65),
          ColorPickers(
            initialColor: Color(widget.note.color),
            onColorSelected: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
        ],
      ),
    );
  }
}
