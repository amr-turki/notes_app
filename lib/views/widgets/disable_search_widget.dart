import 'package:flutter/material.dart';
import 'package:notes/cubits/notes_cubit.dart';

class DisableSearchWidget extends StatelessWidget {
  const DisableSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          const Text(
            'Notes',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 170, 169, 169).withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: IconButton(
              onPressed: () {
                NotesCubit.instance.changeSearchVisibility();
              },
              icon: const Icon(Icons.search, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
