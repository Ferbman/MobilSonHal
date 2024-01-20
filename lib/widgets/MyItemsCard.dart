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
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(right: 10),
                      child: Image.network(item['ImgLink']),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('applications')
                                              .where('itemId',
                                                  isEqualTo: item["itemId"])
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            }
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            if (snapshot.hasData) {
                                              for (var element
                                                  in snapshot.data!.docs) {
                                                print(element["itemId"]);
                                              }
                                              return Row(
                                                children: List.generate(
                                                    snapshot.data!.docs.length,
                                                    (index) => Text(
                                                        // code 15
                                                        snapshot.data!
                                                                    .docs[index]
                                                                ["userName"] +
                                                            "  ")),
                                              );
                                              //hocam ben burda item id ile başvuru itemiid eşitliyordum ki kendisi icinde yazsın boyle yanlıs olmadı mı çevireyim mi

                                              /* ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                 
                                                  if (currentData != null) {
                                                    return Text(
                                                        (currentData as Map)["itemId"]);
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                },
                                              ); */
                                            } else {
                                              return const Center(
                                                child: Text("erro"),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Padding(
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
