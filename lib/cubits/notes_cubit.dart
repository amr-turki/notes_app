import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/models/notes.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  void fetchAllNotes() {
    try {
      emit(NotesLoading());
      List<Notes> notesList = boxNotes.values.cast<Notes>().toList();
      emit(NotesSuccess(notesList));
    } catch (e) {
      emit(NotesFailure('Failed to fetch notes: ${e.toString()}'));
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
