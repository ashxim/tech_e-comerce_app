import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_ecomerce_app/screens/login_screen.dart';
import 'package:my_ecomerce_app/screens/my_home_page.dart';
import 'package:my_ecomerce_app/widgets/btmnavbar.dart';

class FireAuth extends StatefulWidget {
  const FireAuth({super.key});

  @override
  State<FireAuth> createState() => _FireAuthState();
}

class _FireAuthState extends State<FireAuth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Firebase is still initializing; show a loading indicator or something.
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // User is logged in; show the home page.
          return const BtmNavBar();
        } else {
          // User is not logged in; show the login screen.
          return const LoginScreen();
        }
      },
    );
  }
}
