import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_seller_app/authentication/auth_page.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimer() {
    Timer(Duration(seconds: 8), () async {
      // cheking the seller sign up or not
      if (firebaseAuth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthPage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Container(
        color: Color.fromARGB(255, 230, 108, 99),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset('images/d47baf73869221.5c1845a4b8823.jpg'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Sell Food Online',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
