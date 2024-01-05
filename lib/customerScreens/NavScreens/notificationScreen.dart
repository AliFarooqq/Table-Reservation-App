import 'package:bookabite/cards/notificationCard.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final email;
  const NotificationScreen({super.key, this.email});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<List<DocumentSnapshot>> getData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await firestore
        .collection('Orders')
        .where('emailUser', isEqualTo: Variables.emailUser)
        .where('status', isNotEqualTo: 'Pending')
        .get();

    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 6),
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
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        String emailOwner = snapshot.data![index]['emailOwner'];
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Restaurant')
                              .doc(emailOwner)
                              .get(),
                          builder: (context, snapshotUser) {
                            if (snapshotUser.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshotUser.hasError) {
                              return Text('Error: ${snapshotUser.error}');
                            } else {
                              String NtfcImage = snapshotUser.data!['imageUrl'];
                              String restName = snapshotUser.data!['username'];
                              return Material(
                                child: InkWell(
                                  onTap: () {},
                                  child: NtfcCard1(
                                    imagestr: NtfcImage,
                                    status: snapshot.data![index]['status']!,
                                    name: restName,
                                    title: '',
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
      ),
    );
  }
}
