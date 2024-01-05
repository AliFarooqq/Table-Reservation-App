import 'package:bookabite/RestOwnerScreens/AuthScreens/loginOwner.dart';
import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/customerScreens/AuthScreens/loginScreen.dart';
import 'package:flutter/material.dart';

class afterWelcomeScr extends StatelessWidget {
  const afterWelcomeScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // first image
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              opacity: 0.1,
              image: AssetImage(
                  "assets/black pattern-01.png"), // replace with your image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Are you",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                WelcomeButton(
                  buttonText: "Business Owner",
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginOwner())),
                ),
                SizedBox(
                  height: 20,
                ),
                WelcomeButton(
                  buttonText: "Customer",
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                ),
              ],
            ))
      ],
    );
  }
}
