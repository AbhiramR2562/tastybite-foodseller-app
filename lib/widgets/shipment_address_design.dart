import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/model/address.dart';
import 'package:food_seller_app/pages/splash/splash_page.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;
  const ShipmentAddressDesign({
    super.key,
    this.model,
    this.orderStatus,
    this.orderId,
    this.sellerId,
    this.orderByUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Shipping Details: ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 90,
            vertical: 5,
          ),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              //-> Name
              TableRow(
                children: [
                  const Text(
                    "Name:",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(model!.name!),
                ],
              ),

              //-> Phone Number
              TableRow(
                children: [
                  const Text(
                    "Phone Number:",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(model!.phoneNumber!),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),

        // Go back button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SplashPage())),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.lightBlue,
                        Colors.green,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    orderStatus == "ended" ? "Go back" : "Order packing done",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 50),
      ],
    );
  }
}
