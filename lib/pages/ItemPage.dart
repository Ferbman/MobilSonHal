import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zirtavat/services/notification.dart';
import 'package:zirtavat/widgets/ItemAppBar.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key, required this.item});
  final QueryDocumentSnapshot item;
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late User? user = FirebaseAuth.instance.currentUser;

  late String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  late String currentUserName = FirebaseAuth.instance.currentUser!.email!;
  final FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 213, 215, 220),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.item.get('userId'))
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            Map<String, dynamic>? userData =
                snapshot.data?.data() as Map<String, dynamic>?;

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ItemAppBar(),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Image.network(
                          widget.item['ImgLink'],
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Color.fromARGB(255, 213, 215, 220),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 7,
                                  bottom: 7,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.item['name'] ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            'Montserrat', // Corrected font family
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          userData?['userName'] ?? '',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  widget.item['description'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await _firestoreService.applyForItem(
                      currentUserId,
                      currentUserName,
                      widget.item.id,
                    );

                    await NotificationHelper().sendPushMessage(
                        body: "Basvuru aldiniz!",
                        title: "Basvuru",
                        token: userData?["token"]);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Başvur",
                        style: TextStyle(
                          fontFamily: 'Montserrat', // Corrected font family
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

// FirestoreService.dart

class FirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> applyForItem(
      String userId, String userName, String itemId) async {
    // Add an application document to the 'applications' collection
    await FirebaseFirestore.instance.collection('applications').add({
      'userId': userId,
      'itemId': itemId,
      'userName': userName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
