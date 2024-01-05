import 'package:bookabite/Dashboards/ownerDashboard.dart';
import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/Dashboards/customerdashboard.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

String imagePath = '';
String imageName = '';
String imageUrl = '';

class OwnProfileEdit extends StatefulWidget {
  String email;
  OwnProfileEdit({super.key, required this.email});

  @override
  State<OwnProfileEdit> createState() => _OwnProfileEditState();
}

class _OwnProfileEditState extends State<OwnProfileEdit> {
  Widget _image = CircleAvatar(
    child: Image.network(Variables.urlimageOwner),
  );
  String initialName = '';
  String initialEmail = '';
  String initialImageUrl = '';
  String initialPhone = '';
  String initialCity = '';
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var _visible = false;
  var _visible1 = false;
  Future<void> _updateRestaurant(Map<String, dynamic> updates) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('Restaurant').doc(widget.email).update(updates);
  }

  Future<DocumentSnapshot> _fetchRestaurant() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('Restaurant').doc(Variables.emailOwner).get();
  }

  @override
  void initState() {
    super.initState();

    _fetchRestaurant().then((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      initialName = data['username'];
      initialEmail = data['email'];
      initialImageUrl = data['imageUrl'];
      initialPhone = data['phone'];
      initialCity = Variables.cityOwner;
      nameController.text = initialName;
      emailController.text = initialEmail;
      phoneController.text = initialPhone;
    });
  }

  void updateControllersOwners() {
    if (nameController.text.isEmpty) {
      nameController.text = initialName;
    }
    if (emailController.text.isEmpty) {
      emailController.text = initialEmail;
    }
    if (phoneController.text.isEmpty) {
      phoneController.text = initialPhone;
    }
    if (Variables.cityOwner.isEmpty) {
      Variables.cityOwner = initialCity;
    }
    if (imageUrl.isEmpty) {
      imageUrl = initialImageUrl;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/Ellipse 9.png'),
                    radius: 50,
                  ),

                  // _image,
                  // Image.network(Variables.urlimageOwner, height: 100),
                  SizedBox(height: 4),
                  TextButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('No image selected'),
                          ),
                        );
                        return;
                      } else {
                        imagePath = pickedFile.path;
                        imageName = basename(imagePath); // Set imageName here

                        // Upload the image to Firebase Storage
                        final firebaseStorageRef = FirebaseStorage.instance
                            .ref()
                            .child('uploads/$imageName');
                        final uploadTask =
                            firebaseStorageRef.putFile(File(imagePath));
                        await uploadTask.whenComplete(() => null);
                        imageUrl = await firebaseStorageRef.getDownloadURL();

                        setState(() {
                          print(imageUrl);
                          _image = Container(
                            height: 100, // Adjust the size of the image here
                            width: 100, // Adjust the size of the image here
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/cheez.png'),
                                fit: BoxFit
                                    .cover, // This will cover the circular area
                              ),
                            ),
                          );
                        });
                      }
                    },
                    child: Text(
                      'Change Picture',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: nameController,
                      cursorColor: Colors.black,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        // prefixIcon: Icon(Icons.person),
                        prefixIcon: Image.asset(
                          'assets/Profile.png',
                          width: 17,
                          height: 17,
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Image.asset('assets/Message.png'),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: phoneController,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      obscureText: _visible,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(
                          Icons.call_end_outlined,
                        ),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      width: 250,
                      child: DropdownSearch<String>(
                        items: [
                          "Karachi, Pakistan",
                          "Lahore, Pakistan",
                          "Islamabad, Pakistan",
                          "Rawalpindi, Pakistan",
                          "Faisalabad, Pakistan",
                          "Multan, Pakistan",
                          "Gujranwala, Pakistan",
                          "Peshawar, Pakistan",
                          "Quetta, Pakistan",
                          "Sargodha, Pakistan",
                          "Bahawalpur, Pakistan",
                          "Sialkot, Pakistan",
                          "Sukkur, Pakistan",
                          "Larkana, Pakistan",
                          "Sheikhupura, Pakistan",
                          "Mianwali, Pakistan",
                          "Rahim Yar Khan, Pakistan",
                          "Gujrat, Pakistan",
                          "Jhang, Pakistan",
                          "Sahiwal, Pakistan",
                          "Okara, Pakistan",
                          "Wah Cantonment, Pakistan",
                          "Dera Ghazi Khan, Pakistan",
                          "Kasur, Pakistan",
                          "Mardan, Pakistan",
                          "Chiniot, Pakistan",
                          "Daska, Pakistan",
                          "Sambrial, Pakistan",
                          "Pakpattan, Pakistan",
                          "Bahawalnagar, Pakistan",
                          "Toba Tek Singh, Pakistan",
                          "Jhelum, Pakistan",
                          "Khanewal, Pakistan",
                          "Hafizabad, Pakistan",
                          "Kamoke, Pakistan",
                          "Burewala, Pakistan",
                          "Jacobabad, Pakistan",
                          "Muzaffargarh, Pakistan",
                          "Murree, Pakistan",
                          "Haripur, Pakistan"
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            Variables.cityOwner = value ?? '';
                          });
                        },
                        selectedItem: Variables.cityOwner,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 152, 88, 88)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      )),
                  // Space between the avatar and the text
                  // Space between the avatar and the text
                ],
              ),
            ),
            WelcomeButton(
                buttonText: 'Save Details',
                widthh: 300,
                onPressed: () async {
                  if (imagePath == null || imagePath.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('No image selected'),
                      ),
                    );
                    return;
                  }

                  final File imageFile = File(imagePath);

                  if (!imageFile.existsSync()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Image file does not exist'),
                      ),
                    );
                    return;
                  }

                  final firebaseStorageRef = FirebaseStorage.instance
                      .ref()
                      .child('uploads/$imageName');
                  final uploadTask = firebaseStorageRef.putFile(imageFile);
                  final taskSnapshot =
                      await uploadTask.whenComplete(() => null);
                  imageUrl = await taskSnapshot.ref.getDownloadURL();
                  updateControllersOwners();
                  await _updateRestaurant({
                    'username': nameController.text,
                    'email': emailController.text,
                    'imageUrl': imageUrl,
                    'phone': phoneController.text,
                    'city': Variables.cityOwner,
                  });
                  Variables.urlimageOwner = imageUrl;

                  SharedPreferences prefsO =
                      await SharedPreferences.getInstance();
                  await prefsO.setString('email', emailController.text);
                  await prefsO.setString('name', nameController.text);
                  await prefsO.setString('phone', phoneController.text);
                  await prefsO.setString('city', Variables.cityOwner);
                  await prefsO.setString('imageurl', imageUrl);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwnerDashboard(
                          email: widget.email,
                          initialIndex: 2,
                        ),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
