import 'package:book_buy_and_sell/Utils/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_buy_and_sell/Utils/helper/constants.dart';
var user;
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
   var user = FirebaseAuth.instance.currentUser;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      user = FirebaseAuth.instance.currentUser;
      print("--------------------"+user.uid.toString());

      return user.uid.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
  //   final GoogleSignIn _googleSignIn = new GoogleSignIn();
  //
  //   final GoogleSignInAccount googleSignInAccount =
  //       await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken);
  //
  //   AuthResult result = await _auth.signInWithCredential(credential);
  //   FirebaseUser userDetails = result.user;
  //
  //   if (result == null) {
  //   } else {
  //     //Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
  //   }
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
class User {
  final String uid;
  User({this.uid});
}