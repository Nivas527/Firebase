import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'existing.dart';
import 'firebaseauth.dart';
import 'logintwo.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuthService auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController userctrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();

  @override
  void dispose(){
    userctrl.dispose();
    emailctrl.dispose();
    passctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: userctrl,
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailctrl,
              decoration: InputDecoration(
                  labelText: "Email ID"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passctrl,
              decoration: InputDecoration(
                  labelText: "Password"

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: signUp, child: Text("Sign up")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => exist()));
            }, child: Text("Login")),
          ),
          ElevatedButton(onPressed: signInWithGoogle,
              child: Text("Google sign In"))
        ],
      ),
    );
  }

  void signUp() async{
    //String Username = userctrl.text;
    String email = emailctrl.text;
    String password = passctrl.text;

    User? user = await auth.signUpWithEmailAndPassword(email, password);

    if(user != null){
      print("User is Successfully Created");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Logintwo()));
    }else{
      Text("Some error have Occured");
    }
  }

  signInWithGoogle() async {
    //final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
          clientId: '940952432260-alfdeurjnislvogm67c7ggs4sud8ru4i.apps.googleusercontent.com'
      );
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Logintwo()),);
      }

    }catch(e) {
     print("some error Occured $e");
    }
  }
}
