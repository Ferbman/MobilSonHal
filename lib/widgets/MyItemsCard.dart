import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyItemsCard extends StatefulWidget {
  const MyItemsCard({Key? key});

  @override
  State<MyItemsCard> createState() => _MyItemsCardState();
}

class _MyItemsCardState extends State<MyItemsCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('items')
          .where('userId', isEqualTo: currentUserId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                Text('Yükleniyor...'),
              ],
            ),
          ); // Veri yüklenene kadar loading göster
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Verileri çektiğimiz alan
        List<QueryDocumentSnapshot> myItems = snapshot.data!.docs;

        return Column(
          children: [
            for (var item in myItems)
              Container(
                height: 110,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.only(right: 10),
                      child: Image.network(item['ImgLink']),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('applications')
                                .where('userId', isEqualTo: item.id)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.data?.docs == null) {
                                return Text("başvuruyok");
                              } else {
                                var listOfUsers = snapshot.data?.docs;
                                for (var userr in listOfUsers!)
                                  return Column(
                                    children: [
                                      Text(
                                        userr.get('userId'),
                                      ),
                                    ],
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
