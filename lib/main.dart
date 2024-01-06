import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_seller_app/firebase_options.dart';
import 'package:food_seller_app/global/global.dart';
import 'package:food_seller_app/pages/splash/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seller App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashPage(),
    );
  }
}
