import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/home_screen.dart';
import 'package:notes/views/widgets/color_pickers.dart';
import 'package:notes/views/widgets/custom_text_field.dart';

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
  @override
  Widget build(BuildContext context) {
    final TextEditingController TitleController = TextEditingController();
    final TextEditingController ContentController = TextEditingController();
    TitleController.text = widget.note.title;
    ContentController.text = widget.note.content;

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(changeTheme: widget.changeTheme),
                      ),
                    );
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
                Image(
                  height: 35,
                  width: 35,

                  image: AssetImage('assests/icons/sticky-note.png'),
                ),
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
                      final updatedNote = Notes(
                        title: TitleController.text,
                        content: ContentController.text,
                        color: ColorPickers.TargetColor.value,
                        date: DateTime.now().toIso8601String(),
                      );
                      BlocProvider.of<NotesCubit>(
                        context,
                      ).editNote(index: widget.index, updatedNote: updatedNote);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item Edited'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(Icons.check, size: 24),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 65),
          CustomTextField(
            Controller: TitleController,
            text: widget.note.title,
            maxLength: 20,
            maxLines: 1,
          ),

          SizedBox(height: 30),
          CustomTextField(
            Controller: ContentController,
            text: widget.note.content,
            maxLength: 180,
            maxLines: 4,
          ),

          SizedBox(height: 65),
          //color select and choose
          ColorPickers(
            SelectedColor: Color(widget.note.color),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ],
      ),
    );
  }
}
