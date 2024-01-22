import 'package:flutter/material.dart';
import 'package:food_seller_app/authentication/auth_page.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/pages/earnings_page.dart';
import 'package:food_seller_app/pages/history_page.dart';
import 'package:food_seller_app/pages/home_page.dart';
import 'package:food_seller_app/pages/new_orders_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            // Header
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    //fontFamily: "Train",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Drawer Body
          Container(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //Home
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage())),
                ),

                // My earning
                ListTile(
                    leading: const Icon(
                      Icons.monetization_on,
                      color: Colors.black,
                    ),
                    title: const Text(
                      " My earning",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EarningsPage()));
                    }),

                // New Order
                ListTile(
                    leading: const Icon(
                      Icons.reorder,
                      color: Colors.black,
                    ),
                    title: const Text(
                      "New Order",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewOrdersPage()));
                    }),

                // History - orders
                ListTile(
                    leading: const Icon(
                      Icons.history,
                      color: Colors.black,
                    ),
                    title: const Text(
                      "History - orders",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()));
                    }),

                // Sign out
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AuthPage()));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
