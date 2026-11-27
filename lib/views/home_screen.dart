import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/cubits/notes_state.dart';
import 'package:notes/helper/app_assests.dart';
import 'package:notes/views/add_note_screen.dart';
import 'package:notes/views/navigation_drawer.dart';
import 'package:notes/views/widgets/disable_search_widget.dart';
import 'package:notes/views/widgets/enable_search_widget.dart';
import 'package:notes/views/widgets/left_drawer_widget.dart';
import 'package:notes/views/widgets/notes_list_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.changeTheme});
  final Function(ThemeMode) changeTheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Image.asset(AppAssets.addStickyNote),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const AddNote(),
            );
          },
        ),
        drawer: Navigation(changeTheme: changeTheme),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              LeftDrawerWidget(),
              const SizedBox(height: 5),

              NotesCubit.instance.isLoading
                  ? EnableSearchWidget()
                  : DisableSearchWidget(),

              const SizedBox(height: 30),
              Expanded(child: NotesListBuilder(changeTheme: changeTheme)),
            ],
          ),
        ),
      ),
    );
  }
}
