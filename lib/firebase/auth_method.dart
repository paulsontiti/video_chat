import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<User?> get authChanged => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<(String message, bool signedIn)> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firebaseFirestore.collection('users').doc(user.uid).set({
            'userName': user.displayName,
            'uid': user.uid,
            'profilePicture': user.photoURL
          });
        }
      }
      return ('successful', true);
    } on FirebaseAuthException catch (e) {
      return (e.message!, false);
    }
  }
}
