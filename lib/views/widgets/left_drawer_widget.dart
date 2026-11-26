import 'package:flutter/material.dart';

class LeftDrawerWidget extends StatelessWidget {
  const LeftDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu, size: 28),
        ),
      ],
    );
  }
}
