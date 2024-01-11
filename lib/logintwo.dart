import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Login.dart';

class Logintwo extends StatefulWidget {
  const Logintwo({super.key});

  @override
  State<Logintwo> createState() => _LogintwoState();
}

class _LogintwoState extends State<Logintwo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Text("Welcome")),
          ElevatedButton(onPressed: () {
            signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          }, child: Text("Sign out"))
        ],
      ),
    );
  }

  void signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await googleSignIn.signOut();
      await auth.signOut();
      print("User signed out");
    }
    catch (e) {
      print("Error signing out: $e");
    }
  }
}
