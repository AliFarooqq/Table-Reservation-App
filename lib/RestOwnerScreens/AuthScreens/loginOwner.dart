import 'package:bookabite/RestOwnerScreens/AuthScreens/signUPOwner.dart';
import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/Dashboards/ownerDashboard.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginOwner extends StatefulWidget {
  const LoginOwner({super.key});

  @override
  State<LoginOwner> createState() => _LoginOwnerState();
}

class _LoginOwnerState extends State<LoginOwner> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool _isChecked = false;
  var _visible = true;
  String name = '';
  String phone = '';
  String city = '';
  String imageUrl = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      // first image
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Transform.scale(
                scale: 1.5,
                child: Opacity(
                  opacity: 0.08,
                  child: Image(
                    image: AssetImage("assets/black pattern-01.png"),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 150,
                    width: 80,
                  ),
                  // SizedBox(
                  //   height: 3,
                  // ),
                  Text(
                    'BookABite',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              )
            ],
          )),
      SizedBox(
        height: 20,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Container(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff272727), // Semi-transparent black
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), // Adjust the radius as needed
                  topRight: Radius.circular(50), // Adjust the radius as needed
                ),
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: emailController,
                      cursorColor: Colors.grey,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Image.asset(
                          'assets/Message.png',
                          width: 17,
                          height: 17,
                          color: Colors.white,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      obscureText: _visible,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Image.asset(
                          'assets/Lock.png',
                          width: 17,
                          height: 17,
                          color: Colors.white,
                        ),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _visible = !_visible;
                            });
                          },
                          icon: Icon(
                            _visible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  WelcomeButton(
                    buttonText: 'LOGIN',
                    onPressed: () {
                      _auth
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) async {
                        print("Logged in");

                        // // Fetch the user's document from Firestore
                        // DocumentSnapshot userDoc = await FirebaseFirestore
                        //     .instance
                        //     .collection('Restaurant')
                        //     .doc(emailController.text)
                        //     .get();

                        // // Check the 'role' field
                        // if (userDoc['roles'] != 'owner') {
                        //   print('User is not an owner');
                        //   return;
                        // }

                        SharedPreferences prefsW =
                            await SharedPreferences.getInstance();
                        SharedPreferences prefsO =
                            await SharedPreferences.getInstance();
                        await prefsW.setBool('isLoggedIn', true);
                        Variables.emailUser = emailController.text;
                        await prefsO.setString('email', emailController.text);
                        await prefsW.setString('role', 'owner');

                        final FirebaseFirestore firestore =
                            FirebaseFirestore.instance;
                        final DocumentSnapshot doc = await firestore
                            .collection('Restaurant')
                            .doc(emailController.text)
                            .get();

                        if (doc.exists) {
                          final data = doc.data() as Map<String, dynamic>;
                          final name = data['name'] ?? '';
                          final phone = data['phone'] ?? '';
                          final city = data['city'] ?? '';
                          final imageUrl = data['imageUrl'] ?? '';
                          final email = emailController.text;

                          await prefsO.setString('name', name);
                          await prefsO.setString('phone', phone);
                          await prefsO.setString('city', city);
                          await prefsO.setString('imageUrl', imageUrl);
                          await prefsO.setString('email', email);

                          Variables.nameOwner = name;
                          Variables.phoneOwner = phone;
                          Variables.cityOwner = city;
                          Variables.urlimageOwner = imageUrl;
                          Variables.emailOwner = email;
                          print(name);
                          print(email);
                          print(phone);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OwnerDashboard(
                                      email: emailController.text,
                                    )),
                          );
                        }
                      }).catchError((error) => print(error));
                    },
                    widthh: 300,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: _isChecked,
                              autofocus: true,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                              activeColor: Color(0xff2C9C9C9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 15,
                            color: Color(0xFFF1590A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpOwner()),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 15,
                            color: Color(0xFFF1590A),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // replace with your actual second image
    ]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Variables.emailUser);
  }
}
