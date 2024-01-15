import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_seller_app/assistantmethods/assistant_method.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/widgets/order_card.dart';
import 'package:food_seller_app/widgets/simple_app_bar.dart';

class NewOrdersPage extends StatefulWidget {
  const NewOrdersPage({super.key});

  @override
  State<NewOrdersPage> createState() => _NewOrdersPageState();
}

class _NewOrdersPageState extends State<NewOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(
          title: "New Orders",
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("status", isEqualTo: "normal")
              .where("sellerUID",
                  isEqualTo: sharedPreferences!.getString("uid"))
              .snapshots(),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index) {
                      return FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("items")
                              .where("itemID",
                                  whereIn: separateOrdersItemIDs((snapshot
                                          .data!.docs[index]
                                          .data()!
                                      as Map<String, dynamic>)["productIDs"]))
                              .where("sellerUID",
                                  whereIn: (snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>)["uid"])
                              .orderBy("publishedDate", descending: true)
                              .get(),
                          builder: (c, snap) {
                            return snap.hasData
                                ? OrderCard(
                                    itemCount: snap.data!.docs.length,
                                    data: snap.data!.docs,
                                    orderID: snapshot.data!.docs[index].id,
                                    separateQuantitiesList:
                                        separateOrderItemQuantities(
                                            (snapshot.data!.docs[index].data()!
                                                    as Map<String, dynamic>)[
                                                "productIDs"]),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          });
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
