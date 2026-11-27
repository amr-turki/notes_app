import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/views/splash_screen.dart';

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
    return BlocProvider.value(
      value: NotesCubit.instance,
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
