import 'package:flutter/material.dart';
import 'package:notes/Hive_box_const.dart';
import 'package:notes/notes.dart';
import 'package:notes/views/widgets/color_pickers.dart';
import 'package:notes/views/widgets/custom_text_field.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController TitleController = TextEditingController();
    final TextEditingController ContentController = TextEditingController();

    final Color color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          SizedBox(height: 45),

          CustomTextField(
            Controller: TitleController,
            text: 'Title',
            maxLength: 20,
            maxLines: 1,
          ),

          SizedBox(height: 15),
          CustomTextField(
            Controller: ContentController,
            text: 'Content',
            maxLength: 180,
            maxLines: 4,
          ),
          SizedBox(height: 15),
          ColorPickers(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          SizedBox(height: 15),

          GestureDetector(
            onTap: () {
              boxNotes.put(
                'key_${TitleController.text}',
                Notes(
                  color: ColorPickers.TargetColor!.value,
                  content: TitleController.text,
                  date: DateTime.now().toString(),
                  title: TitleController.text,
                ),
              );

              Navigator.of(context).pop();
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
