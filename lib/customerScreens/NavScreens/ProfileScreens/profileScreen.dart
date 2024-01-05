import 'package:bookabite/RestOwnerScreens/NavScreens/profileScreens/ownEditProfile.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:bookabite/customerScreens/BookingScreens/tableScreen.dart';
import 'package:bookabite/welcomeScreens/afterWelcomeScr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/customerScreens/NavScreens/ProfileScreens/editProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<DocumentSnapshot> _fetchUser() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (Variables.emailUser == null || Variables.emailUser.isEmpty) {
      throw Exception('User email is null or empty');
    }
    return firestore.collection('Users').doc(Variables.emailUser).get();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Variables.emailUser);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
            future: _fetchUser(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return Text('User not found');
              } else if (snapshot.data!['username'] == null) {
                return Text('Username not found');
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 50), // Space before the avatar
                          CircleAvatar(
                            backgroundImage: NetworkImage(Variables.urlimage),
                            radius: 50,
                          ),

                          SizedBox(
                              height:
                                  16), // Space between the avatar and the text
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data!['username'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  Variables.cityUser = snapshot.data!['city'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Member since ' + snapshot.data!['startyear'],
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Space between the name and the ID
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[],
                          ),
                          SizedBox(height: 24), // Space before the options
                          buildOptionRow(context, 'assets/Setting.png',
                              'Edit profile', EditProfile()),
                          buildOptionRow(
                              context,
                              'assets/Send.png',
                              'Tell your friends',
                              null), // Replace null with the relevant screen or function
                          buildOptionRow(
                              context,
                              'assets/Wallet.png',
                              'Payments',
                              null), // Replace null with the relevant screen or function
                          SizedBox(
                              height: 24), // Space before the logout button
                        ],
                      ),
                      WelcomeButton(
                        buttonText: "Logout",
                        onPressed: () => {
                          signOut(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => afterWelcomeScr()),
                          )
                        },
                      ),
                    ],
                  ),
                );
              }
            }));
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      // After signing out, set 'isLoggedIn' to false in shared preferences
      SharedPreferences prefsW = await SharedPreferences.getInstance();
      await prefsW.setBool('isLoggedIn', false);

      print('User signed out successfully');
    } catch (e) {
      print('Failed to sign out: $e');
      // Handle the error appropriately in your app
    }
  }

  Widget buildOptionRow(
      BuildContext context, String icon, String text, Widget? navigatedPage) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(icon),
              SizedBox(width: 20),
              Text(text),
            ],
          ),
          InkWell(
            onTap: () => navigatedPage != null
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => navigatedPage))
                : {}, // Add your onTap functionality here
            child: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
