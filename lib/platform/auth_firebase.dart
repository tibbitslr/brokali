import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class BroAuthFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map> getUser() async {
    return _format(await _auth.currentUser());
  }

  Future<String> getUserId() async {
    return (await _auth.currentUser())?.uid;
  }

  Future<Map> signInWithEmail(String email, String password) async {
    return _format(await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ));
  }

  Future<Map> signUpWithEmail(String email, String password) async {
    return null;
    // return _format(await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // ));
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Map _format(FirebaseUser fireUser) {
    if (fireUser == null) return null;

    return {
      'uid': fireUser.uid,
      'email': fireUser.email,
      // 'name': fireUser.displayName,
      // 'photoUrl': fireUser.photoUrl,
    };
  }
}
