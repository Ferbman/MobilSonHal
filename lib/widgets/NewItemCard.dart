import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class newItem extends StatefulWidget {
  final GlobalKey<FormState> currentState = GlobalKey<FormState>();

  @override
  State<newItem> createState() => _newItemState();
}

class _newItemState extends State<newItem> {
  final _firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();
  String uniqeFileName = '';
  String imageUrl = '';
  String user = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    CollectionReference itemsRef = _firestore.collection('items');

    return Column(
      children: [
        Container(
          height: 500,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ürün Giriniz.",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: const Color.fromARGB(255, 172, 168, 168)),
                    ),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Ürün ismi",
                        prefixIcon: Icon(Icons.add_outlined, size: 30),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: const Color.fromARGB(255, 172, 168, 168)),
                    ),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: "Ürün Açıklaması",
                        prefixIcon: Icon(Icons.add_outlined, size: 30),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? image = await imagePicker.pickImage(
                              source: ImageSource.gallery, imageQuality: 50);

                          String uniqeFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');
                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqeFileName);
                          try {
                            await referenceImageToUpload
                                .putFile(File(image!.path));
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                          } catch (e) {}
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.photo_size_select_actual_sharp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          String itemid =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          if (imageUrl.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("resim yükle")));
                          }
                          print(descriptionController.text);
                          print(descriptionController.text);
                          print(uniqeFileName);

                          Map<String, dynamic> items = {
                            'description': descriptionController.text,
                            'name': nameController.text,
                            'ImgLink': imageUrl,
                            'userId': user,
                          };

                          itemsRef.doc(itemid).set(items);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.done,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
