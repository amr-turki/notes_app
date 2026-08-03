import 'package:flutter/material.dart';

class ColorPickers extends StatefulWidget {
  const ColorPickers({
    super.key,
    required this.onColorSelected,
    this.initialColor,
  });

  final Function(Color) onColorSelected;
  final Color? initialColor;

  @override
  State<ColorPickers> createState() => _ColorPickersState();
}

class _ColorPickersState extends State<ColorPickers> {
  final List<Color> colors = const [
    Color(0xFFFFF4B7),
    Color(0xFFFFCAD4),
    Color(0xFFB5E2FA),
    Color(0xFFEDF2F4),
    Color(0xFFF1C0B9),
  ];

  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor ?? colors[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: colors.map((color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = color;
              });

              widget.onColorSelected(color);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: selectedColor == color
                  ? Colors.black
                  : Colors.transparent,
              child: CircleAvatar(radius: 22, backgroundColor: color),
            ),
          );
        }).toList(),
      ),
    );
  }
}
