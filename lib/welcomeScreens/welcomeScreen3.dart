import 'package:bookabite/welcomeScreens/afterWelcomeScr.dart';
import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:flutter/material.dart';

class welcomeScreen3 extends StatefulWidget {
  const welcomeScreen3({super.key});

  @override
  State<welcomeScreen3> createState() => _welcomeScreen3State();
}

class _welcomeScreen3State extends State<welcomeScreen3> {
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
              'assets/welcome s3 img.png',
              height: 200,
              width: 175,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Table reservations made easy",
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
                      "Book your favourite restaurant table effortlessly with us",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ) // add this line
                ),
            WelcomeButton(
              buttonText: "Get Started",
              widthh: 300,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => afterWelcomeScr()),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    color: Color(0xff272727),
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
