import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes/cubits/notes_cubit.dart';
import 'package:notes/cubits/notes_state.dart';
import 'package:notes/helper/app_assests.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/views/add_note.dart';
import 'package:notes/views/edit_note.dart';
import 'package:notes/views/navigation_drawer.dart';
import 'package:notes/views/widgets/note_item.dart';

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
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Image(image: AssetImage(AppAssets.stickyNote)),
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
            const SizedBox(height: 10),
            Row(
              children: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu, size: 28),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),

            search
                ? TextField(
                    autofocus: true,
                    onChanged: (value) {
                      BlocProvider.of<NotesCubit>(context).searchNotes(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a note...',
                      prefixIcon: Icon(Icons.arrow_back),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            search = !search;
                          });
                          BlocProvider.of<NotesCubit>(context).searchNotes('');
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.note_alt_outlined,
                              size: 80,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No notes found.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        Notes note = notesList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12, top: 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditNote(
                                    index: index,
                                    note: note,

                                    changeTheme: widget.changeTheme,
                                  ),
                                ),
                              );
                            },
                            child: Slidable(
                              key: const ValueKey(0),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(16),

                                    onPressed: (context) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditNote(
                                            index: index,
                                            note: note,
                                            changeTheme: widget.changeTheme,
                                          ),
                                        ),
                                      );
                                    },
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    icon: Icons.drive_file_rename_outline,
                                    label: 'Edit Notes',
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(16),

                                    onPressed: (context) {
                                      setState(() {
                                        BlocProvider.of<NotesCubit>(
                                          context,
                                        ).deleteNote(notesList[index]);
                                      });
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Item deleted'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: NoteItem(note: notesList[index]),
                            ),
                          ),
                        );
                      },
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
