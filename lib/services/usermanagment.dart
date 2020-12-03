import 'package:admin/AddItem/addcat.dart';
import 'package:admin/AddItem/addproduct.dart';
import 'package:admin/AddItem/addsubcat.dart';
import 'package:admin/AddItem/product.dart';
import 'package:admin/Dashborad/staffdashbord.dart';



import 'package:admin/StoreDisplay/store.dart';

import 'package:admin/commanpages/commanWidgets.dart';
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminPanel()));

          }else{
            if(docs.documents[0].data['role']=='staff'){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StaffPanel()));

          }}
        }
      });

    });

  }



}


class UserAccess{


  authorizedAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("/Staff").
      where('uid',isEqualTo: user.uid).
      getDocuments().
      then((docs){
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'admin'){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Item()), (route)=>false);
          }else{
            if(docs.documents[0].data['role']=='staff'){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Store()), (route)=>false);
            }}
        }
      });

    });

  }



}

class UserAccessEdit{


  authorizedAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("/Staff").
      where('uid',isEqualTo: user.uid).
      getDocuments().
      then((docs){
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'admin'){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> AddCat(text: "Updating")), (route)=>false);
          }else{
            if(docs.documents[0].data['role']=='staff'){
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            20.0),
                      ),
                      child: Container(
                        height: 150.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              EdgeInsets.only(
                                  top: 20.0),
                              child: Text(
                                "Only admin can edit",
                                style: Theme.of(
                                    context)
                                    .textTheme
                                    .display1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.all(
                                  30.0),
                              child: Material(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    20.0),
                                elevation: 4.0,
                                child: InkWell(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      20.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child:
                                  Container(
                                    height: 40.0,
                                    width: 100.0,
                                    decoration:
                                    BoxDecoration(
                                      gradient:
                                      LinearGradient(
                                        begin: Alignment
                                            .topLeft,
                                        end: Alignment
                                            .bottomRight,
                                        colors: [
                                          const Color(
                                              0xFF185a9d),
                                          const Color(
                                              0xFF43cea2)
                                        ],
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(
                                          20.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                          "okay",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });

            }}
        }
      });

    });

  }



}


class UserAccessSubCatEdit{


  authorizedAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("/Staff").
      where('uid',isEqualTo: user.uid).
      getDocuments().
      then((docs){
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'admin'){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> AddSubCat(text: 'Updating')), (route)=>false);
          }else{
            if(docs.documents[0].data['role']=='staff'){
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            20.0),
                      ),
                      child: Container(
                        height: 150.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              EdgeInsets.only(
                                  top: 20.0),
                              child: Text(
                                "Only admin can edit",
                                style: Theme.of(
                                    context)
                                    .textTheme
                                    .display1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.all(
                                  30.0),
                              child: Material(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    20.0),
                                elevation: 4.0,
                                child: InkWell(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      20.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child:buttonContainer(context, "okay", 40.0, 100.0)

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });

            }}
        }
      });

    });

  }



}

class UserAccessProductEdit{


  authorizedAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("/Staff").
      where('uid',isEqualTo: user.uid).
      getDocuments().
      then((docs){
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'admin'){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProduct(text: 'updating')));

          }else{
            if(docs.documents[0].data['role']=='staff'){
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            20.0),
                      ),
                      child: Container(
                        height: 150.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              EdgeInsets.only(
                                  top: 20.0),
                              child: Text(
                                "Only admin can edit",
                                style: Theme.of(
                                    context)
                                    .textTheme
                                    .display1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.all(
                                  30.0),
                              child: Material(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    20.0),
                                elevation: 4.0,
                                child: InkWell(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      20.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child:
                                  Container(
                                    height: 40.0,
                                    width: 100.0,
                                    decoration:
                                    BoxDecoration(
                                      gradient:
                                      LinearGradient(
                                        begin: Alignment
                                            .topLeft,
                                        end: Alignment
                                            .bottomRight,
                                        colors: [
                                          const Color(
                                              0xFF185a9d),
                                          const Color(
                                              0xFF43cea2)
                                        ],
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(
                                          20.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                          "okay",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });

            }}
        }
      });

    });

  }



}
