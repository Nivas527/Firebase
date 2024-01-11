import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'logintwo.dart';
import 'firebaseauth.dart';

class exist extends StatefulWidget {
  const exist({super.key});

  @override
  State<exist> createState() => _existState();
}

class _existState extends State<exist> {

  final FirebaseAuthService auth = FirebaseAuthService();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: emailctrl,
            decoration: InputDecoration(
              labelText: "Enter Email ID"
            ),
          ),
          TextFormField(
            controller: passctrl,
            decoration: InputDecoration(
              labelText: "Password"
            ),
          ),
          ElevatedButton(onPressed: signIn, child: Text("Login"))
        ],
      ),
    );
  }

  void signIn() async{
    String email = emailctrl.text;
    String password = passctrl.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);

    if(user != null){
      print("User is Successfully Created");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Logintwo()));
    }else{
      Text("Some error have Occured");
    }
  }
}
