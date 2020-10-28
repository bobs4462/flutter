import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  Future<void> _submitAuthForm({
    @required String email,
    @required String userName,
    @required String pass,
    @required bool isLogin,
    @required File image,
    @required BuildContext ctx,
  }) async {
    UserCredential userCredential;
    try {
      setState(() => _isLoading = true);
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: pass);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user.uid}.jpg');
        await ref.putFile(image).onComplete;
        final url = await ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'userName': userName,
          'email': email,
          'image': url,
        });
      }
      setState(() => _isLoading = false);
    } on PlatformException catch (error) {
      setState(() => _isLoading = false);
      var message = 'Error occured';
      if (error.message != null) {
        message = error.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitAuthForm, _isLoading),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
