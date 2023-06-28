import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'pages/homePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform login logic here
                Navigator.pushNamed(context, '/account');
              },
              child: Text('Login'),

@override
dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

SignInWithGoogle() async {
  GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();

  GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;

  AuthCredential credential= GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);

  print(userCredential.user?.displayName); 

  if (userCredential.user != null) {
    // Navigator.of(context as BuildContext).push(MaterialPageRoute(
    //   builder: (BuildContext context) =>HomePage(title: 'homepage')
    // ));
  }
            ),
          ],
        ),
      ),
    );
  }
}
