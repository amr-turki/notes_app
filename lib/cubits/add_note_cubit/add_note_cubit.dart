import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/helper/hive_error_mapper.dart';
import 'package:notes/models/notes.dart';
import 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit._internal() : super(AddNoteInitial());
  static final AddNoteCubit instance = AddNoteCubit._internal();

  Future<void> addNote(Notes note) async {
    try {
      emit(AddNoteLoading());

      await boxNotes.add(note);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(mapHiveExceptionToMessage(e)));
    }
  }
}
