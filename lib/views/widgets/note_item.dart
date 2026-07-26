import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/helper/Hive_box_const.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
    super.key,
    required this.color,
    required this.Title,
    required this.note,
    required this.time,
    required this.index,
  });

  final Color color;
  final String Title;
  final String note;
  final String time;
  final int index;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,

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
                  widget.Title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: Text(
                widget.note,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              trailing: Container(
                margin: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: widget.color.withOpacity(0.3),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      BlocProvider.of<NotesCubit>(
                        context,
                      ).deleteNote(widget.index);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item deleted'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    });
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
                  widget.time,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
