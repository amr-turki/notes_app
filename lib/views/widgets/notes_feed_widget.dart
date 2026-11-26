import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/edit_note_screen.dart';
import 'package:notes/views/widgets/note_item_widget.dart';

class NotesFeedWidget extends StatelessWidget {
  const NotesFeedWidget({
    super.key,
    required this.notesList,
    required this.changeTheme,
  });
  final List<Notes> notesList;
  final Function(ThemeMode) changeTheme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notesList.length,
      itemBuilder: (context, index) {
        Notes note = notesList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12),
          child: GestureDetector(
            onTap: () {
              _editNote(context, index);
            },
            child: Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(16),

                    onPressed: (context) {
                      _editNote(context, index);
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.drive_file_rename_outline,
                    label: 'Edit Notes',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(16),

                    onPressed: (context) {
                      _deleteItem(context, index);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: NoteItem(note: notesList[index]),
            ),
          ),
        );
      },
    );
  }

  void _editNote(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNote(
          index: index,
          note: notesList[index],
          changeTheme: changeTheme,
        ),
      ),
    );
  }

  void _deleteItem(BuildContext context, int index) {
    BlocProvider.of<NotesCubit>(context).deleteNote(notesList[index]);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item deleted'), duration: Duration(seconds: 2)),
    );
  }
}
