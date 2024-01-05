import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/Dashboards/customerdashboard.dart';
import 'package:flutter/material.dart';

class ThkuScreen extends StatefulWidget {
  const ThkuScreen({super.key});

  @override
  State<ThkuScreen> createState() => _ThkuScreenState();
}

class _ThkuScreenState extends State<ThkuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // This centers the column vertically.
                children: <Widget>[
                  CircleAvatar(
                    radius: 60, // Size of the circle
                    backgroundColor: Color(0xffF1590A),
                    child: Icon(
                      Icons.check,
                      size: 70, // Size of the check icon
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20), // Space between the icon and the text
                  Text(
                    'Thank you, table reserved successfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, // Font size for the text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 20), // Space from the bottom edge
                child: WelcomeButton(
                  buttonText: 'Continue',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
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
