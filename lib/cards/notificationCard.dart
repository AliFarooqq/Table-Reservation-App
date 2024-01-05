import 'package:bookabite/core/utils/variables.dart';
import 'package:flutter/material.dart';

class NtfcCard extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String date;
  final String people;

  const NtfcCard(
      {super.key,
      required this.title,
      required this.time,
      required this.date,
      required this.people,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 05, horizontal: 5),
        height: 70,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(width: 10),
              Container(
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(image),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'You got Table reservation request from ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: title,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' for ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' today',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class NtfcCard1 extends StatelessWidget {
  final String imagestr;
  final String status;
  final String title;
  final String name;

  const NtfcCard1(
      {super.key,
      required this.imagestr,
      required this.status,
      required this.title,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 05, horizontal: 5),
        height: 70,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(width: 10),
              Container(
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(imagestr),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Your Table reservation request at ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' is ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: status,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
