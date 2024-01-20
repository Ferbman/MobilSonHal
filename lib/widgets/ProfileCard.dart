import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCart extends StatefulWidget {
  const ProfileCart({Key? key}) : super(key: key);

  @override
  State<ProfileCart> createState() => _ProfileCartState();
}

class _ProfileCartState extends State<ProfileCart> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid) // Aktif kullanıcının UID'si
          .snapshots(),
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // or any other loading indicator
        }
        var userData = snapshot.data;
        return Column(
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                      height: 120,
                      width: 120,
                      margin: EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              userData?['profilePhotoUrl'],
                            ),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userData?['userName'],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  color:
                                      const Color.fromARGB(255, 172, 168, 168)),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            userData?['email'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 172, 168, 168),
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0,
                                  color:
                                      const Color.fromARGB(255, 172, 168, 168)),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            userData?['telNo'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 172, 168, 168),
                            ),
                          ),
                        ),
                        Text(
                          "Girişimci, Yazılımcı",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 172, 168, 168),
                          ),
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
