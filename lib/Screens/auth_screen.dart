import 'package:authorize_user/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    UserCredential credential;
    
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.additionalUserInfo.providerId)
          .set({
        'username': username,
        'email': email,
      });
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
      });
      var message = 'Error occurred, please check your credentials';

      if (e.message != null) {
        message = e.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
