import 'package:bookabite/Dashboards/ownerDashboard.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../cards/notificationCard.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class OwnerHomeScreen extends StatefulWidget {
  String email = '';
  OwnerHomeScreen({super.key, required this.email});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  Future<List<DocumentSnapshot>> getData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await firestore
        .collection('Orders')
        .where('emailOwner', isEqualTo: widget.email)
        .where('status', isEqualTo: 'Pending')
        .get();

    return querySnapshot.docs;
  }

  Future<DocumentSnapshot> _fetchRestaurants() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('Restaurant').doc(widget.email).get();
  }

  Future<DocumentSnapshot> _fetchUsers() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('Users').doc(widget.email).get();
  }

  final String user = "Owner";
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
              Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OwnerDashboard(
                              email: widget.email,
                              initialIndex: 2,
                            ))),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(Variables.urlimageOwner),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardCard(
                    cardColor: Color(0xff9BCF63),
                    title: 'Today Bookings',
                    value: 16,
                  ),
                  DashboardCard(
                    cardColor: Color(0xffE7505F),
                    title: 'Total Bookings',
                    value: 135,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardCard(
                    cardColor: Color(0xffFCC84F),
                    title: 'Total Reviews',
                    value: 4,
                  ),
                  DashboardCard(
                    cardColor: Color(0xff5695E6),
                    title: 'Cancelled Bookings',
                    value: 9,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text('Recent Notifications',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 5),
              Expanded(
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String emailUser = snapshot.data![index]['emailUser'];
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(emailUser)
                                .get(),
                            builder: (context, snapshotUser) {
                              if (snapshotUser.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshotUser.hasError) {
                                return Text('Error: ${snapshotUser.error}');
                              } else {
                                String nameUser =
                                    snapshotUser.data!['username'];
                                String imageUrl =
                                    snapshotUser.data!['imageurl'];
                                return Material(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirmation'),
                                            content: IntrinsicHeight(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'Do you want to accept this order?'),
                                                  SizedBox(height: 10),
                                                  Text('Customer: ' + nameUser),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'Order Time: ${snapshot.data![index]['time']}'),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Order Date: ${DateFormat('d MMMM, y').format(DateTime.parse(snapshot.data![index]['date']))}',
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'Order Status: ${snapshot.data![index]['status']}'),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'Reserved for : ${snapshot.data![index]['people']}'),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Agree'),
                                                onPressed: () async {
                                                  final FirebaseFirestore
                                                      firestore =
                                                      FirebaseFirestore
                                                          .instance;
                                                  await firestore
                                                      .collection('Orders')
                                                      .doc(snapshot
                                                          .data![index].id)
                                                      .update({
                                                    'status': 'Accepted'
                                                  });
                                                  print('User agreed.');
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Disagree'),
                                                onPressed: () async {
                                                  final FirebaseFirestore
                                                      firestore =
                                                      FirebaseFirestore
                                                          .instance;
                                                  await firestore
                                                      .collection('Orders')
                                                      .doc(snapshot
                                                          .data![index].id)
                                                      .update({
                                                    'status': 'Rejected'
                                                  });
                                                  print('User agreed.');
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: NtfcCard(
                                      title: nameUser,
                                      image: imageUrl,
                                      time: snapshot.data![index]['time'],
                                      date: snapshot.data![index]['date'],
                                      people: snapshot.data![index]['people'],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class DashboardCard extends StatefulWidget {
  final Color cardColor;
  final String title;
  final int value;

  DashboardCard({
    super.key,
    required this.cardColor,
    required this.title,
    required this.value,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 03, horizontal: 10),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            widget.value.toString(),
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
