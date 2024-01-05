import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/core/utils/variables.dart';

import 'package:bookabite/customerScreens/BookingScreens/reserveScreen.dart';
import 'package:bookabite/Dashboards/customerdashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  final email;
  TableScreen({
    this.email,
    super.key,
  });

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  Future<DocumentSnapshot> _fetchRestaurant() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('Restaurant').doc(widget.email).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(
                          initialIndex: 3,
                        ))),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage('assets/Ellipse 9.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(width: 10), // Optional: to give some spacing
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchRestaurant(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data!['username'],
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 17,
                                ),
                                Text(
                                  '4.9',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: _fetchRestaurant(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Container(
                                height: 200,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(Variables.urlimageOwner),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Adjust this as per your requirement
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  // Handle the button press here
                                },
                                child: RichText(
                                    text: TextSpan(
                                  text: 'Call Manager',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ))),
                            TextButton(
                                onPressed: () {
                                  // Handle the button press here
                                },
                                child: RichText(
                                    text: TextSpan(
                                  text: 'View Website',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ))),
                            TextButton(
                                onPressed: () {
                                  // Handle the button press here
                                },
                                child: RichText(
                                    text: TextSpan(
                                  text: 'Get Directions',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  WelcomeButton(
                    buttonText: 'Reserve a Table',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReserveScreen(
                          email: snapshot.data!['email'],
                        ),
                      ),
                    ),
                    widthh: 330,
                    fontt: 20,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
