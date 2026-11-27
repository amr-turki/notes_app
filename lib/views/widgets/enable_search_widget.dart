import 'package:flutter/material.dart';
import 'package:notes/cubits/notes_cubit.dart';

class EnableSearchWidget extends StatelessWidget {
  const EnableSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onChanged: (value) {
        NotesCubit.instance.searchNotes(value);
      },
      decoration: InputDecoration(
        hintText: 'Search for a note...',
        prefixIcon: IconButton(
          onPressed: () {
            NotesCubit.instance.changeSearchVisibility();
          },
          icon: Icon(Icons.arrow_back),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            NotesCubit.instance.changeSearchVisibility();
          },
          icon: Icon(Icons.close),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
