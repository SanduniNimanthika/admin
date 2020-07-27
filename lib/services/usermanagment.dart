import 'package:admin/mainpages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/Dashborad/admindashbord.dart';

class UserManagment{
  Widget handleAuth() {
    return new StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: ( BuildContext context, snapshot ) {
          if (snapshot.hasData) {
            return Dashbord();
          }
          return Homepage();
        });
  }
  authorizedAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("/Staff").
      where('uid',isEqualTo: user.uid).
      getDocuments().
      then((docs){
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'admin'){
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context )=>Homepage()));
          }
        }
      });

    });

  }

}