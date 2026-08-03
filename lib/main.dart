import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NotesAdapter());
  final Box<Notes> boxNotes = await Hive.openBox<Notes>('notesbox');

  runApp(NotesApplication(notesBox: boxNotes));
}

class NotesApplication extends StatefulWidget {
  const NotesApplication({super.key, required this.notesBox});
  final Box<Notes> notesBox;

  @override
  State<NotesApplication> createState() => _NotesApplicationState();
}

class _NotesApplicationState extends State<NotesApplication> {
  ThemeMode _themeMode = ThemeMode.system;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(widget.notesBox),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(primarySwatch: Colors.green),

        // standard dark theme
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        home: SplahScreen(changeTheme: changeTheme),
      ),
    );
  }
}
