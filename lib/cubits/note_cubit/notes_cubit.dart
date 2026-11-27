import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/helper/hive_error_mapper.dart';
import 'package:notes/models/notes.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit._internal() : super(NotesInitial()) {
    fetchAllNotes();
  }

  static final NotesCubit instance = NotesCubit._internal();

  List<Notes> _allNotes = [];
  bool isLoading = false;
  void changeSearchVisibility() {
    isLoading = !isLoading;
    if (!isLoading) {
      emit(NotesSuccess(_allNotes));
    } else {
      emit(NotesSuccess(_allNotes));
    }
  }

  void fetchAllNotes() {
    try {
      emit(NotesLoading());
      _allNotes = boxNotes.values.cast<Notes>().toList();
      emit(NotesSuccess(_allNotes));
    } catch (e) {
      String friendlyMessage = mapHiveExceptionToMessage(e);
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

  void deleteNote(Notes note) async {
    try {
      await note.delete();
      fetchAllNotes();
    } catch (e) {
      String friendlyMessage = mapHiveExceptionToMessage(e);
      emit(NotesFailure(friendlyMessage));
    }
  }
}
