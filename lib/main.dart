import 'package:bookabite/Dashboards/customerdashboard.dart';
import 'package:bookabite/Dashboards/ownerDashboard.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:bookabite/firebase_options.dart';
import 'package:bookabite/welcomeScreens/afterWelcomeScr.dart';
import 'package:bookabite/welcomeScreens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashScreen(),
    );
  }
}

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    nextpage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // first image

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                image: AssetImage(
                    "assets/white pattern.png"), // replace with your image
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF1590A),
                  Color(0xFF9B0F01),
                ], // replace with your desired colors
              ),
            ),
          ),

          // second image
          Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 170,
                    width: 110,
                  ),
                  Text(
                    'BookABite',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ) // replace with your actual second image
              ),
        ],
      ),
    );
  }

  Future<void> nextpage() async {
    await Future.delayed(Duration(seconds: 3), () {});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String role = prefs.getString('role') ?? '';

    if (role == 'owner') {
      Variables.emailOwner = prefs.getString('email') ?? '';
      Variables.nameOwner = prefs.getString('name') ?? '';
      Variables.phoneOwner = prefs.getString('phone') ?? '';
      Variables.cityOwner = prefs.getString('address') ?? '';
      Variables.urlimageOwner = prefs.getString('imageUrl') ?? '';
    } else if (role == 'user') {
      Variables.emailUser = prefs.getString('email') ?? '';
      Variables.nameUser = prefs.getString('name') ?? '';
      Variables.phoneUser = prefs.getString('phone') ?? '';
      Variables.cityUser = prefs.getString('address') ?? '';
      Variables.urlimage = prefs.getString('imageUrl') ?? '';
    }

    if (isLoggedIn) {
      if (true) {
        // if(role == 'customer'){

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => afterWelcomeScr()));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => welcomeScreen()));
    }
  }
}
