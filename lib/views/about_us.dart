import 'package:flutter/material.dart';
import 'package:notes/helper/app_assests.dart';
import 'package:notes/views/home_screen.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key, required this.changeTheme});
  final Function(ThemeMode) changeTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'About Us',

            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              size: 38,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 1),

            Image(
              height: 75,
              width: 75,

              image: AssetImage(AppAssets.stickyNote),
            ),
            SizedBox(height: 34),
            Text(
              'Smart Notes',
              style: TextStyle(
                fontSize: 23,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 24),
            Divider(thickness: 2, indent: 20, endIndent: 20),
            SizedBox(height: 24),
            Text(
              'About The App',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'A modern Notes Application...',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
