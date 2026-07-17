import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/models/notes.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<Notes> _allNotes = [];
  void fetchAllNotes() {
    try {
      emit(NotesLoading());
      _allNotes = boxNotes.values.cast<Notes>().toList();
      emit(NotesSuccess(_allNotes));
    } catch (e) {
      emit(NotesFailure('Failed to fetch notes: ${e.toString()}'));
    }
  }

  void searchNotes(String query) {
    if (query.isEmpty) {
      emit(NotesSuccess(_allNotes));
    } else {
      final filteredNotes = _allNotes.where((note) {
        final titleMatch = note.title.toLowerCase().contains(
          query.toLowerCase(),
        );
        final contentMatch = note.content.toLowerCase().contains(
          query.toLowerCase(),
        );
        return titleMatch || contentMatch;
      }).toList();

      emit(NotesSuccess(filteredNotes));
    }
  }

  void addNote(Notes note) {
    try {
      boxNotes.put('key_${note.title}', note);
      fetchAllNotes();
    } catch (e) {
      emit(NotesFailure('Failed to add new note: ${e.toString()}'));
    }
  }

  void editNote({required int index, required Notes updatedNote}) {
    try {
      boxNotes.putAt(index, updatedNote);
      fetchAllNotes();
    } catch (e) {
      emit(NotesFailure('Failed to update the note: ${e.toString()}'));
    }
  }

  void deleteNote(int index) {
    try {
      boxNotes.deleteAt(index);
      fetchAllNotes();
    } catch (e) {
      emit(NotesFailure('Failed to delete the note: ${e.toString()}'));
    }
  }
}
