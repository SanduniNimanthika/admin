import 'package:admin/Dashborad/staffdashbord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/Dashborad/Admindashbord.dart';


class UserManagment{


  authorizedAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("/Staff").
      where('uid',isEqualTo: user.uid).
      getDocuments().
      then((docs){
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'admin'){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminPanel()), (route)=>false);
          }else{
            if(docs.documents[0].data['role']=='staff'){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>StaffPanel()), (route)=>false);
          }}
        }
      });

    });

  }



}
