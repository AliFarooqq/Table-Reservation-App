import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/customerScreens/AuthScreens/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _visible = true;
  bool _visible1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      // first image
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 1.5,
          alignment: Alignment.topCenter,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Transform.scale(
                scale: 1.8,
                child: const Opacity(
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
                  const Text(
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
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff272727), // Semi-transparent black
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), // Adjust the radius as needed
                  topRight: Radius.circular(50), // Adjust the radius as needed
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: nameController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Image.asset(
                          'assets/Profile.png',
                          color: Colors.white,
                          width: 17,
                          height: 17,
                        ),
                        hintText: 'Name',
                        hintStyle: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Image.asset(
                          'assets/Message.png',
                          color: Colors.white,
                        ),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      obscureText: _visible,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Image.asset(
                          'assets/Lock.png',
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
                        hintStyle: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: confirmpasswordController,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      obscureText: _visible,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Image.asset(
                          'assets/Lock.png',
                          color: Colors.white,
                        ),
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _visible1 = !_visible1;
                            });
                          },
                          icon: Icon(
                            _visible1 ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  WelcomeButton(
                      buttonText: ' SIGNUP',
                      onPressed: () async {
                        String password = passwordController.text;
                        String confirmPassword = confirmpasswordController.text;

                        // Check if the password is secure
                        if (password.length < 8) {
                          print('Password should be at least 8 characters');
                          return;
                        }

                        // Check if the password matches the confirm password
                        if (password != confirmPassword) {
                          print('Password and confirm password do not match');
                          return;
                        }

                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: password,
                          );
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(emailController.text)
                              .set({
                            // 'roles': 'customer',
                            'username': nameController.text,
                            'email': emailController.text,
                            'imageurl': '',
                            'city': '',
                            'phone': '',
                            'startyear': DateTime.now().year.toString(),
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        } catch (e) {
                          print('Failed to sign up: $e');
                          // Handle the error appropriately in your app
                        }
                      },
                      widthh: 300),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
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
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Login',
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
}
