import 'package:flutter/material.dart';
import 'package:food_seller_app/authentication/auth_page.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/uploadpage/menu_upload_page.dart';
import 'package:food_seller_app/widgets/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MenuUploadPage())),
              icon: const Icon(
                Icons.post_add,
                color: Colors.white,
              ))
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
