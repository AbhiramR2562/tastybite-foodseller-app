import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/model/items.dart';
import 'package:food_seller_app/pages/splash/splash_page.dart';
import 'package:food_seller_app/widgets/simple_app_bar.dart';

class ItemDetailsPage extends StatefulWidget {
  final Items? model;
  const ItemDetailsPage({super.key, this.model});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  // Controller
  final itemCountController = TextEditingController();

  // Delete Method
  deleteItem(String itemID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID)
        .collection("items")
        .doc(itemID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection("items").doc(itemID).delete();

      Fluttertoast.showToast(msg: "Item deleteted successfully");
    });
  }

  // Delete Method with Confirmation Dialog
  void deleteItemWithConfirmation(String itemID) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this item?"),
            actions: <Widget>[
              // Cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),

              // Delete button
              TextButton(
                onPressed: () {
                  deleteItem(itemID);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SplashPage()));
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: sharedPreferences!.getString("name"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                widget.model!.thumbnailUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text(
              "Price: " + widget.model!.price.toString() + "\$",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () {
                deleteItemWithConfirmation(widget.model!.itemID!);
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.red,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(12)),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Delete this item",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
