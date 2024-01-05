import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/welcomeScreens/welcomeScreen2.dart';
import 'package:flutter/material.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/welcome s1 img.png',
              height: 200,
              width: 175,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Discover restaurants near you",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ) // add this line
                ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      "We make it simple to find for you. Enter the address and let us do the rest",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ) // add this line
                ),
            WelcomeButton(
                buttonText: "Get Started",
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => welcomeScreen2()),
                    ),
                widthh: 300),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    color: Color(0xff272727),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    color: Color(0xff2C9C9C9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    color: Color(0xffC9C9C9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
