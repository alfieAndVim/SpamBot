import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      print('Successful signon');
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  getUID() {
    var currentUser = _auth.currentUser;
    return currentUser?.uid;
  }
}
