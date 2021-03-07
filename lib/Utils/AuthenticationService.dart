import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> signIn({String email, String password}) async {

    if (email == '' || password == '') {
      Fluttertoast.showToast(
          msg: 'El campo email y contraseña no pueden estar vacíos',
          backgroundColor: Colors.white,
          textColor: Colors.red);
      return false;
    }

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'No se ha encontrador un usuario con ese email',
            backgroundColor: Colors.white,
            textColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: 'La contraseña no coincide',
            backgroundColor: Colors.white,
            textColor: Colors.red);
      }
    }

    return false;
  }

  Future<bool> signUp({String email, String password}) async {

    if (email == '' || password == '') {
      Fluttertoast.showToast(
          msg: 'El campo email y contraseña no pueden estar vacíos',
          backgroundColor: Colors.white,
          textColor: Colors.red);
      return false;
    }

    try {
      final User usuario = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password)).user;

      // Se guarda al usuario en la base de datos
      await FirebaseFirestore.instance
          .collection('users')
          .doc(usuario.uid)
          .set({'id': usuario.uid, 'email': usuario.email, 'favoritos' : []});


      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: 'La contraseña debe tener un mínimo de 6 caracteres',
            backgroundColor: Colors.white,
            textColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'Ya hay un usuario registrado con $email',
            backgroundColor: Colors.white,
            textColor: Colors.red);
      }
    }

    return false;
  }

  Future<UserCredential> signUpWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}