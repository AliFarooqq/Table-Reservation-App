// this Screen was not used in the app

import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/customerScreens/BookingScreens/tableScreen.dart';
import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  final email;
  const BookingsScreen({super.key, this.email});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(children: [
        SizedBox(height: 50),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Bookings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        SizedBox(height: 6),
        Expanded(
          // Add this
          child: ListView.builder(
            itemCount: 5, // Set this to the number of items you want
            itemBuilder: (context, index) {
              return ListRest(
                imageUrl2: 'assets/cheez.png',
                title2: 'Cheezious',
                rating2: 4.9,
                tables2: '5',
              );
            },
          ),
        )
      ]),
    );
  }
}

class ListRest extends StatefulWidget {
  final String imageUrl2;
  final String title2;
  final double rating2;
  final String tables2;

  ListRest({
    required this.imageUrl2,
    required this.title2,
    required this.rating2,
    required this.tables2,
  });

  @override
  _ListRestState createState() => _ListRestState();
}

class _ListRestState extends State<ListRest> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 110,
        width: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  widget.imageUrl2,
                  width: 110,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Flexible(
                      child: Text(
                        "You have booking at " + widget.title2 + " for 4pm",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  WelcomeButton(
                    buttonText: "Cancel Booking",
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TableScreen()),
                      ),
                    },
                    widthh: 115,
                    heightt: 25,
                    bradius: 5,
                    fontt: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
