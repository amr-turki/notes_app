import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/app.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/models/notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NotesAdapter());
  boxNotes = await Hive.openBox<Notes>('notesbox');

  runApp(NotesApplication());
}
