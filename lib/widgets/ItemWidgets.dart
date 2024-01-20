import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zirtavat/pages/ItemPage.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  /* ItemsWidget({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }
  late Stream<QuerySnapshot> _stream;

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('items');*/
  final firestore = FirebaseFirestore.instance; //
  FirebaseAuth auth = FirebaseAuth
      .instance; //recommend declaring a reference outside the methods

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('items').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<QueryDocumentSnapshot> items = snapshot.data!.docs;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10.78),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemPage(item: item),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(1),
                      child: Image.network(
                        item['ImgLink'] ??
                            'https://firebasestorage.googleapis.com/v0/b/jetget-dc76f.appspot.com/o/ProductImages%2Fyok.png?alt=media&token=eeb62242-9308-40dc-8aab-4e109fc23564',
                        height: 160,
                        width: 160,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(item.get('userId'))
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                          Container(
                            padding: EdgeInsets.only(bottom: 8, left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(userData?['userName'] ?? ''),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.add_shopping_cart_outlined,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
