import 'package:bookabite/cards/notificationCard.dart';
import 'package:bookabite/core/utils/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnerNotification extends StatefulWidget {
  String email;
  OwnerNotification({super.key, required this.email});

  @override
  State<OwnerNotification> createState() => _OwnerNotificationState();
}

class _OwnerNotificationState extends State<OwnerNotification> {
  @override
  void initState() {
    super.initState();
    print(widget.email);
  }

  Future<List<DocumentSnapshot>> getData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await firestore
        .collection('Orders')
        .where('emailOwner', isEqualTo: widget.email)
        .where('status', isEqualTo: 'Pending')
        .get();

    return querySnapshot.docs;
  }

  Future<void> _updateUser(Map<String, dynamic> updates) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('Orders').doc('').update(updates);
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
                        String emailUser = snapshot.data![index]['emailUser'];
                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(emailUser)
                              .get(),
                          builder: (context, snapshotUser) {
                            if (snapshotUser.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshotUser.hasError) {
                              return Text('Error: ${snapshotUser.error}');
                            } else {
                              String imageUrl = snapshotUser.data!['imageurl'];
                              String nameUser = snapshotUser.data!['username'];
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
                                                    FirebaseFirestore.instance;
                                                await firestore
                                                    .collection('Orders')
                                                    .doc(snapshot
                                                        .data![index].id)
                                                    .update(
                                                        {'status': 'Accepted'});
                                                print('User agreed.');
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Disagree'),
                                              onPressed: () async {
                                                final FirebaseFirestore
                                                    firestore =
                                                    FirebaseFirestore.instance;
                                                await firestore
                                                    .collection('Orders')
                                                    .doc(snapshot
                                                        .data![index].id)
                                                    .update(
                                                        {'status': 'Rejected'});
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
                                    image: imageUrl,
                                    title: nameUser,
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
      ),
    );
  }
}
