import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
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
      String friendlyMessage = _mapExceptionToMessage(e);
      emit(NotesFailure(friendlyMessage));
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
      String friendlyMessage = _mapExceptionToMessage(e);
      emit(NotesFailure(friendlyMessage));
    }
  }

  void editNote({required int index, required Notes updatedNote}) {
    try {
      boxNotes.putAt(index, updatedNote);
      fetchAllNotes();
    } catch (e) {
      String friendlyMessage = _mapExceptionToMessage(e);
      emit(NotesFailure(friendlyMessage));
    }
  }

  void deleteNote(Notes note) async {
    try {
      await note.delete();
      fetchAllNotes();
    } catch (e) {
      String friendlyMessage = _mapExceptionToMessage(e);
      emit(NotesFailure(friendlyMessage));
    }
  }

  String _mapExceptionToMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('box not open') ||
        errorString.contains('closed')) {
      return 'Unable to access notes. The local database is not open.';
    } else if (errorString.contains('hive') ||
        errorString.contains('database')) {
      return 'A database error occurred while fetching your notes.';
    } else if (error is FormatException || errorString.contains('type cast')) {
      return 'Corrupted data format detected in saved notes.';
    } else {
      return 'An unexpected error occurred while loading notes. Please try again later.';
    }
  }
}
