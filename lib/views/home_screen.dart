import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/helper/Hive_box_const.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Image(image: AssetImage('assests/icons/sticky-notes.png')),
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
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Search for a note...',
                      prefixIcon: Icon(Icons.arrow_back),
                      suffixIcon: IconButton(
                        onPressed: () {
                          search = !search;
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
            // تعديل: تم لف الـ ListView بـ Expanded حتى لا يسبب خطأ في الـ Column
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: boxNotes.listenable(),
                builder: (context, value, child) => ListView.builder(
                  itemCount: boxNotes.length,
                  itemBuilder: (context, index) {
                    Notes note = boxNotes.getAt(index);
                    // تعديل: إضافة كلمة return هنا ضرورية جداً
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
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
                                onPressed: (context) {
                                  setState(() {
                                    boxNotes.deleteAt(index);
                                  });
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: NoteItem(
                            index: index,
                            color: Color(note.color),
                            Title: note.title,
                            note: note.content,
                            time: note.date.substring(0, 10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
