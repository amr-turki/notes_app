import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/models/notes.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({super.key, required this.note});

  final Notes note;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(widget.note.color),

        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 12.0,
          left: 12,
          top: 18,
          bottom: 12,
        ),
        child: Column(
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  widget.note.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: Text(
                widget.note.content,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              trailing: Container(
                margin: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(widget.note.color).withOpacity(0.3),
                ),
                child: IconButton(
                  onPressed: () {
                    _deleteItem(context);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Spacer(),
                Text(
                  widget.note.date.substring(0, 10),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteItem(BuildContext context) {
    NotesCubit.instance.deleteNote(widget.note);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item deleted'), duration: Duration(seconds: 2)),
    );
  }
}
