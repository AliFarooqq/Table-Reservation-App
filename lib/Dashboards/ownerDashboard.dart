import 'package:bookabite/RestOwnerScreens/NavScreens/ownerHomeScreen.dart';
import 'package:bookabite/RestOwnerScreens/NavScreens/ownerNotificartion.dart';
import 'package:bookabite/RestOwnerScreens/NavScreens/profileScreens/ownerProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OwnerDashboard extends StatefulWidget {
  final int initialIndex;
  final email;

  OwnerDashboard({super.key, this.initialIndex = 0, this.email});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  Future<DocumentSnapshot> _fetchRestaurant() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('Restaurant').doc(widget.email).get();
  }

  late int _selectedIndex;
  late List<Widget> pages = [];
  @override
  void initState() {
    super.initState();
    pages = [
      OwnerHomeScreen(email: widget.email),
      OwnerNotification(email: widget.email),
      OwnerProfile(email: widget.email),
    ];
    // Ensure _selectedIndex is within the bounds of the pages list
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
            children: List.generate(pages.length, (index) {
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
