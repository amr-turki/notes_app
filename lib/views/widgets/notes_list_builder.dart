import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/cubits/notes_state.dart';
import 'package:notes/views/widgets/no_notes_found_widget.dart';
import 'package:notes/views/widgets/notes_feed_widget.dart';

class NotesListBuilder extends StatelessWidget {
  const NotesListBuilder({super.key, required this.changeTheme});
  final Function(ThemeMode) changeTheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NotesSuccess) {
          return state.notes.isEmpty
              ? const NoNotesFoundWidget()
              : NotesFeedWidget(
                  notesList: state.notes,
                  changeTheme: changeTheme,
                );
        } else if (state is NotesFailure) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
