import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/splah_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(NotesAdapter());
  boxNotes = await Hive.openBox<Notes>('notesbox');
  await Hive.initFlutter();

  runApp(NotesApplication());
}

class NotesApplication extends StatefulWidget {
  const NotesApplication({super.key});

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
      create: (context) => NotesCubit(),
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
