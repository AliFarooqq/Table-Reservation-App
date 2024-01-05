import 'package:flutter/material.dart';

class GreyBtns extends StatefulWidget {
  final String buttonText;
  final Widget navigatedPage;
  final double widthh;
  final double heightt;
  final double fontt;
  final double bradius;

  const GreyBtns({
    super.key,
    required this.buttonText,
    required this.navigatedPage,
    this.widthh = 300,
    this.heightt = 50,
    this.fontt = 10,
    this.bradius = 6,
  });

  @override
  State<GreyBtns> createState() => _GreyBtnsState();
}

class _GreyBtnsState extends State<GreyBtns> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Center(
        // Add this line
        child: Container(
          decoration: BoxDecoration(
            color: _isSelected ? Color(0xffC0C0C0) : Color(0xffEBEBEB),
            borderRadius: BorderRadius.circular(10),
          ),
          width: widget.widthh,
          height: widget.heightt,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.buttonText,
              style: TextStyle(
                fontSize: widget.fontt,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
