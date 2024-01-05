import 'package:bookabite/core/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookabite/bookingsScreen.dart';
import 'package:bookabite/customerScreens/NavScreens/mainScreen.dart';
import 'package:bookabite/customerScreens/NavScreens/notificationScreen.dart';
import 'package:bookabite/customerScreens/NavScreens/ProfileScreens/profileScreen.dart';

class User {
  final String name;
  final String city;
  final String imageUrl;
  final String email;
  final syear;
  final String phone;

  User({
    required this.name,
    required this.city,
    this.imageUrl = '',
    required this.email,
    this.syear = 2024,
    this.phone = '',
  });

  static User fromDocument(DocumentSnapshot doc) {
    return User(
        name: doc['name'],
        city: doc['city'],
        imageUrl: doc['imageUrl'],
        email: doc['email'],
        syear: doc['startyear'],
        phone: doc['phone']);
  }
}

class Dashboard extends StatefulWidget {
  final int initialIndex;

  const Dashboard({super.key, this.initialIndex = 0});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late User user;
  late int _selectedIndex;
  late List<Widget> pages = [
    MainScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    print(Variables.emailUser);
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, pages.length - 1);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0, // Only needed if there is a FAB with notch
        child: Container(
          height: 60, // Adjust height to fit your design
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xffEBEBEB)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              return IconButton(
                // icon: Icon(
                //   getIconForIndex(index),
                //   color: _selectedIndex == index ? Colors.orange : Colors.grey,
                //
                // ),
                icon: Image.asset(
                  _getImage(index),
                  width: index == 0 && _selectedIndex != 0 ? 20 : null,
                  height: index == 0 && _selectedIndex != 0 ? 20 : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  String _getImage(index) {
    switch (index) {
      case 0:
        if (_selectedIndex == index) {
          return 'assets/HomeSet.png';
        } else {
          return 'assets/Home.png';
        }
      case 1:
        if (_selectedIndex == index) {
          return 'assets/NotificationSet.png';
        } else {
          return 'assets/Notification.png';
        }

      case 2:
        if (_selectedIndex == index) {
          return 'assets/ProfileSet.png';
        } else {
          return 'assets/Profile.png';
        }
      default:
        return 'assets/HomeSet.png';
    }
  }
}
