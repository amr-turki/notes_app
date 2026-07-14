import 'package:flutter/material.dart';

class ColorPickers extends StatefulWidget {
  const ColorPickers({super.key, required this.color, this.SelectedColor});

  final Color color;
  static Color TargetColor = Colors.white;

  final Color? SelectedColor;

  @override
  State<ColorPickers> createState() => _ColorPickersState();
}

class _ColorPickersState extends State<ColorPickers> {
  @override
  Widget build(BuildContext context) {
    bool isBlack = false;
    if (Colors.white == widget.color) {
      isBlack = !isBlack;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              ColorPickers.TargetColor = Color(0xFFFFF4B7);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFFFF4B7) == widget.SelectedColor
                  ? isBlack
                        ? Colors.white
                        : Colors.black
                  : widget.color,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFFFF4B7),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ColorPickers.TargetColor = Color(0xFFFFCAD4);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFFFCAD4) == widget.SelectedColor
                  ? isBlack
                        ? Colors.white
                        : Colors.black
                  : widget.color,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFFFCAD4),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ColorPickers.TargetColor = Color(0xFFB5E2FA);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFB5E2FA) == widget.SelectedColor
                  ? isBlack
                        ? Colors.white
                        : Colors.black
                  : widget.color,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFB5E2FA),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ColorPickers.TargetColor = Color(0xFFEDF2F4);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFEDF2F4) == widget.SelectedColor
                  ? isBlack
                        ? Colors.white
                        : Colors.black
                  : widget.color,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFEDF2F4),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ColorPickers.TargetColor = Color(0xFFF1C0B9);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0xFFF1C0B9) == widget.SelectedColor
                  ? isBlack
                        ? Colors.white
                        : Colors.black
                  : widget.color,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFF1C0B9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
