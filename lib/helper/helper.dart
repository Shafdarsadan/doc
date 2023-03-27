import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Helper {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<User?> getUserCredentials()async{
    final current_user  = await _firebaseAuth.currentUser;
    return current_user;
  }
  Future<bool>  isUsersigned() async{
   return await _firebaseAuth.currentUser == null? false:true;
  }
  Future<void>  firebasecreateuser({required String email,required String password })async{
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
  Future<void>   firebaselogin({required String email,required String password })=>_firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> firebaseSignout()=> _firebaseAuth.signOut();
}