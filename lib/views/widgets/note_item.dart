import 'package:flutter/material.dart';
import 'package:notes/helper/Hive_box_const.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.color,
    required this.Title,
    required this.note,
    required this.time, required this.index,
  });

  final Color color;
  final String Title;
  final String note;
  final String time;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,

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
                  Title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: Text(
                note,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              trailing: Container(
                margin: EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color.withOpacity(0.3),
                ),
                child: IconButton(onPressed: () {                                   boxNotes.deleteAt(index);}, icon: Icon(Icons.delete)),
              ),
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Spacer(),
                Text(time, style: TextStyle(fontSize: 14, color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
