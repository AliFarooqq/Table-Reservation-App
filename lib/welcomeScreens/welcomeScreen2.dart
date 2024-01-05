import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/welcomeScreens/welcomeScreen3.dart';
import 'package:flutter/material.dart';

class welcomeScreen2 extends StatefulWidget {
  const welcomeScreen2({super.key});

  @override
  State<welcomeScreen2> createState() => _welcomeScreen2State();
}

class _welcomeScreen2State extends State<welcomeScreen2> {
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
              'assets/welcome S2 img.png',
              height: 200,
              width: 175,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Collection of different cuisines",
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
                      "We have wide variety of dishes. You can enjoy your favouvite dishes with us.",
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
                MaterialPageRoute(builder: (context) => welcomeScreen3()),
              ),
              widthh: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    color: Color(0xffC9C9C9),
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
                    color: Color(0xff2272727),
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
