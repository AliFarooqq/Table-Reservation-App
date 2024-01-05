import 'package:bookabite/buttons/greyButtons.dart';
import 'package:bookabite/buttons/welcomebutton.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:bookabite/customerScreens/BookingScreens/tableScreen.dart';
import 'package:bookabite/Dashboards/customerdashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  final email;
  const MainScreen({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String user = "Ali";
  String location = "Islamabad,Pakistan";
  var searchController = TextEditingController();

  // List<Map<String, dynamic>> restaurants = [
  //   {
  //     'imageUrl': 'assets/butt.png',
  //     'title': 'Butt Karahi',
  //     'rating': 4.5,
  //     'tables': '5',
  //   },
  //   {
  //     'imageUrl': 'assets/unk.png',
  //     'title': 'Khan Trainer',
  //     'rating': 4.5,
  //     'tables': '2',
  //   },
  //   {
  //     'imageUrl': 'assets/cheez.png',
  //     'title': 'Cheezious',
  //     'rating': 4.9,
  //     'tables': '7',
  //   },

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Hello, ",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: user,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ) // add this line
                ),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                            initialIndex: 2,
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
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/Location.png', height: 20),
                Text(Variables.cityUser),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 30,
              child: TextField(
                controller: searchController,
                cursorHeight: 13,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                  hintText: "Search for restaurants",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Nearby Restaurants',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Restaurant')
                    // .where('city', isEqualTo: Variables.cityUser)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  List<Map<String, dynamic>> restaurants =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    data['id'] = document.id;
                    return data;
                  }).toList();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return NearbyRest(
                        email: restaurants[index]['email'], // Static image
                        imageUrl: restaurants[index]
                            ['imageUrl'], // Static image
                        title: restaurants[index]
                            ['username'], // Name from Firestore
                        rating: 4.5, // Static rating
                        tables: '5', // Static tables
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GreyBtns(
                    buttonText: 'All',
                    navigatedPage: MainScreen(),
                    widthh: 24,
                    heightt: 19),
                GreyBtns(
                    buttonText: 'Recommended',
                    navigatedPage: MainScreen(),
                    widthh: 101,
                    heightt: 19),
                GreyBtns(
                    buttonText: 'Favourites',
                    navigatedPage: MainScreen(),
                    widthh: 60,
                    heightt: 19),
                GreyBtns(
                    buttonText: 'Top Rated',
                    navigatedPage: MainScreen(),
                    widthh: 69,
                    heightt: 19),
                GreyBtns(
                    buttonText: 'Free Tables',
                    navigatedPage: MainScreen(),
                    widthh: 74,
                    heightt: 19),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              // This will allow the ListView to take up the remaining space
              child: StreamBuilder<QuerySnapshot>(
                stream: searchController.text.isEmpty
                    ? FirebaseFirestore.instance
                        .collection('Restaurant')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Restaurant')
                        .where('emailLower'.toLowerCase(),
                            isEqualTo: searchController.text.toLowerCase())
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  List<Map<String, dynamic>> restaurants =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    data['id'] = document.id;
                    print(
                        'Restaurant email: ${data['email']}'); // Print the email
                    return data;
                  }).toList();

                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      print(
                          'Building item with email: ${restaurants[index]['email']}'); // Print the email
                      return ListRest(
                        email: restaurants[index]['email'], // Static image
                        imageUrl2: restaurants[index]
                            ['imageUrl'], // Static image
                        title2: restaurants[index]
                            ['username'], // Name from Firestore
                        rating2: 4.5, // Static rating
                        tables2: '2', // Static tables
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NearbyRest extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final String tables;
  final String email;

  NearbyRest({
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.tables,
    required this.email,
  });

  @override
  State<NearbyRest> createState() => _NearbyRestState();
}

class _NearbyRestState extends State<NearbyRest> {
  bool _isSelected = false;

  @override
  void setState(VoidCallback fn) {
    print('${widget.email} hwllo');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(12),
        height: 150,
        width: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, // To evenly distribute the Column children
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    widget.imageUrl,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        Text(
                          widget.rating.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  widget.tables + ' tables available ',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WelcomeButton(
                  buttonText: "Book Now",
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TableScreen(
                                email: widget.email,
                              )),
                    ),
                  },
                  widthh: 95,
                  heightt: 22,
                  bradius: 3,
                  fontt: 9,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isSelected = !_isSelected;
                    });
                  },
                  child: FaIcon(
                    _isSelected
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: _isSelected ? Colors.red : Colors.grey,
                    size: 16.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListRest extends StatefulWidget {
  final String imageUrl2;
  final String title2;
  final double rating2;
  final String tables2;
  final String email;

  ListRest({
    required this.imageUrl2,
    required this.title2,
    required this.rating2,
    required this.tables2,
    required this.email,
  });

  @override
  _ListRestState createState() => _ListRestState();
}

class _ListRestState extends State<ListRest> {
  bool isFavorite = false;

  @override
  void setState(VoidCallback fn) {
    print('${widget.email} hwllo');
  }

  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 90,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  widget.imageUrl2,
                  width: 110,
                  height: 75,
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
                  Column(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.title2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.tables2 + ' tables available ',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  WelcomeButton(
                    buttonText: "Book Now",
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TableScreen(
                                  email: widget.email,
                                )),
                      ),
                    },
                    widthh: 95,
                    heightt: 20,
                    bradius: 3,
                    fontt: 9,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 20,
                    ),
                    Text(
                      widget.rating2.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 17,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
