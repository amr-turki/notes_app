import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/helper/Hive_box_const.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/splah_screen.dart';

Future main() async {
  // It is used so that void main function can
  // be intiated after successfully intialization of data
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(NotesAdapter());
  boxNotes = await Hive.openBox<Notes>('notesbox');
  // To intialise the hive database
  await Hive.initFlutter();

  // To open the user hive box
  runApp(NotesApplication());
}

class Amr extends StatefulWidget {
  const Amr({super.key});

  @override
  State<Amr> createState() => _AmrState();
}

class _AmrState extends State<Amr> {
  ThemeMode? _themeMode = ThemeMode.system;
  void ChangeTheme(ThemeMode? themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,

      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            if (_themeMode == ThemeMode.light) {
              ChangeTheme(ThemeMode.dark);
            } else {
              ChangeTheme(ThemeMode.light);
            }
          },

          child: Center(
            child: Text(
              'Amr',
              style: TextStyle(color: Colors.blueAccent, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
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
      child:  MaterialApp(
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
