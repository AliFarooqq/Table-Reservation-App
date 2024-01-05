import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double widthh;
  final double heightt;
  final double fontt;
  final double bradius;

  const WelcomeButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.widthh = 300,
    this.heightt = 50,
    this.fontt = 15,
    this.bradius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: widthh,
          height: heightt,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFF1590A),
            borderRadius: BorderRadius.circular(bradius),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: fontt,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
