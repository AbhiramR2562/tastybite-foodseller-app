import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/model/menus.dart';
import 'package:food_seller_app/pages/home_page.dart';
import 'package:food_seller_app/widgets/error_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

class itemsUploadPage extends StatefulWidget {
  final Menus? model;
  const itemsUploadPage({super.key, this.model});

  @override
  State<itemsUploadPage> createState() => _itemsUploadPageState();
}

class _itemsUploadPageState extends State<itemsUploadPage> {
  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  final shortInfoController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  XFile? imageXFile;
  final _picker = ImagePicker();

//=> Add new menu page
  DefaultPage() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.orange,
                  Colors.red,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: const Text(
          "Add new item",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shop_two,
                size: 200,
                color: Colors.grey[600],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    // Adjust the radius as needed
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  takeImage(context);
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Image menu"),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture with camera",
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
                onPressed: pickCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select from Gallery",
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
                onPressed: pickGallery,
              ),
              SimpleDialogOption(
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  pickCamera() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXFile;
    });
  }

  pickGallery() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXFile;
    });
  }

  //=> Uploading menu page
  itemsUploadFormPage() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.orange,
                  Colors.red,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: const Text(
          "Upload new item",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => clearItemUploadForm(),
            icon: const Icon(Icons.arrow_back)),
        actions: [
          TextButton(
              onPressed: uploading ? null : () => validateUploadForm(),
              child: Text(
                "Add",
                style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ))
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? LinearProgressIndicator() : const Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(
                      File(
                        imageXFile!.path,
                      ),
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ),
          //Title
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.grey[700],
                ),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "title",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Info
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.grey[700],
                ),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "info",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // border: InputBorder.none,
                ),
              ),
            ),
          ),

          //description
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.grey[700],
                ),
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "description",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Price
          ListTile(
            leading: const Icon(
              Icons.currency_rupee,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  // border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Clear Menu
  clearItemUploadForm() {
    setState(() {
      shortInfoController.clear();
      titleController.clear();
      descriptionController.clear();
      priceController.clear();
      imageXFile = null;
    });
  }

  //
  validateUploadForm() async {
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        // Upload Image
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        //Save info to firestore
        saveInfo(downloadUrl);
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                  message: "Please write info and title...");
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
                message: "Please pick a image for menu...");
          });
    }
  }

  // Save info
  saveInfo(String downloadUrl) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID)
        .collection("items");

    ref.doc(uniqueIdName).set({
      "itemID": uniqueIdName,
      "menuID": widget.model!.menuID,
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "shortInfo": shortInfoController.text.toString(),
      "longDescription": descriptionController.text.toString(),
      "price": int.parse(priceController.text),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "availabel",
      "thumbnailUrl": downloadUrl,
    }).then((value) {
      final itemRef = FirebaseFirestore.instance.collection("items");
      itemRef.doc(uniqueIdName).set({
        "itemID": uniqueIdName,
        "menuID": widget.model!.menuID,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shortInfoController.text.toString(),
        "longDescription": descriptionController.text.toString(),
        "price": int.parse(priceController.text),
        "title": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "availabel",
        "thumbnailUrl": downloadUrl,
      });
    }).then((value) {
      clearItemUploadForm();
      setState(() {
        uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
        uploading = false;
      });
    });
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("items");

    storageRef.UploadTask uploadTask =
        reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? DefaultPage() : itemsUploadFormPage();
  }
}
