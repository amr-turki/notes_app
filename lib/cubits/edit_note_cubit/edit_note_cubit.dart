import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/helper/hive_error_mapper.dart';
import 'package:notes/models/notes.dart';
import 'edit_note_state.dart';

class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit._internal() : super(EditNoteInitial());
  static final EditNoteCubit instance = EditNoteCubit._internal();

  Future<void> editNote({
    required int index,
    required Notes updatedNote,
  }) async {
    try {
      emit(EditNoteLoading());
      await boxNotes.putAt(index, updatedNote);
      emit(EditNoteSuccess());
    } catch (e) {
      emit(EditNoteFailure(mapHiveExceptionToMessage(e)));
    }
  }
}
