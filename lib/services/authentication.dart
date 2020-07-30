
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/module/staff.dart';
import 'package:admin/database/staffdatabase.dart';







class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;


  //user object based on firebased
  Staff _staffFromFirebaseUser(FirebaseUser user){
    return user!=null?Staff(
        staffkey:user.uid,
        email:user.email): null;
  }

  //auth change  user steam
  Stream<Staff>get user{
    return _auth.onAuthStateChanged.map(_staffFromFirebaseUser);
  }

  // sign up
  Future   registerWithEmailAndPassword(String email,String password,String role,BuildContext context) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateStaffData(email, role, 'staffname', 'address', '0000000000');
      return _staffFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }



  // sign in
  Future   signInWithEmailAndPassword(String email,String password,BuildContext context) async{
    try{

      AuthResult result=await _auth.signInWithEmailAndPassword(email:email, password: password);
      FirebaseUser user=result.user;



      return _staffFromFirebaseUser(user);
    }catch(e){

    }
  }

  //sign out
  Future signOut(BuildContext context) async{
    try{

      return await _auth.signOut();

    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
