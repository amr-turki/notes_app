import 'package:flutter/material.dart';
import 'package:notes/views/about_us.dart';
import 'package:notes/views/home_screen.dart';
import 'package:notes/views/settings.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key, required this.changeTheme});
  final Function(ThemeMode) changeTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 110,
                height: 140,
                child: Image(
                  image: AssetImage('assests/icons/sticky-note.png'),
                ),
              ),
            ),
            SizedBox(height: 104),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),

                  Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Settings(changeTheme: changeTheme);
                    },
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Icon(
                      Icons.settings,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),

                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AboutUs(changeTheme: changeTheme);
                    },
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),

                  Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
