import 'package:flutter/material.dart';
import 'package:notes/views/home_screen.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key,required this.changeTheme});
  final Function(ThemeMode) changeTheme;

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(changeTheme: widget.changeTheme)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 170,
          width: 120,

          child: Image(image: AssetImage('assests/icons/sticky-note.png')),
        ),
      ),
    );
  }
}
