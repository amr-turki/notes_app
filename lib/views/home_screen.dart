import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/cubits/notes_state.dart';
import 'package:notes/helper/app_assests.dart';
import 'package:notes/views/add_note_screen.dart';
import 'package:notes/views/navigation_drawer.dart';
import 'package:notes/views/widgets/left_drawer_widget.dart';
import 'package:notes/views/widgets/no_notes_found_widget.dart';
import 'package:notes/views/widgets/notes_feed_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.changeTheme});
  final Function(ThemeMode) changeTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool search = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Image.asset(AppAssets.addStickyNote),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddNote(),
          );
        },
      ),
      drawer: Navigation(changeTheme: widget.changeTheme),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            LeftDrawerWidget(),
            const SizedBox(height: 5),

            search
                ? TextField(
                    autofocus: true,
                    onChanged: (value) {
                      BlocProvider.of<NotesCubit>(context).searchNotes(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a note...',
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            search = !search;
                          });
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            search = !search;
                          });
                        },
                        icon: Icon(Icons.close),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        const Text(
                          'Notes',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              170,
                              169,
                              169,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                search = !search;
                              });
                            },
                            icon: const Icon(Icons.search, size: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 30),
            Expanded(
              child: BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  if (state is NotesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NotesSuccess) {
                    final notesList = state.notes;

                    if (notesList.isEmpty) {
                      return NoNotesFoundWidget();
                    }

                    return NotesFeedWidget(
                      notesList: state.notes,
                      changeTheme: widget.changeTheme,
                    );
                  }

                  if (state is NotesFailure) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
