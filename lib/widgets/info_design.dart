import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/model/menus.dart';
import 'package:food_seller_app/pages/item_page.dart';

class InfoDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;
  InfoDesignWidget({super.key, this.model, this.context});

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  // // Delete Method
  deleteMenu(String menuID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Menu Deleted Successfully");
  }

  // Delete Method with Confirmation Dialog
  void deleteMenuWithConfirmation(String menuID) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this menu?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  deleteMenu(menuID);
                  Navigator.pop(context);
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
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemPage(
                    model: widget.model,
                  ))),
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 5),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.model!.menuTitle!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      // fontFamily: "Train",
                    ),
                  ),
                  // Delete button
                  IconButton(
                    onPressed: () {
                      deleteMenuWithConfirmation(widget.model!.menuID!);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              Text(
                widget.model!.menuInfo!,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 5),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
