import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/user.dart';
class DatabaseServiceUser{
  final String uid;

  DatabaseServiceUser({this.uid,});


  //database collection
  final CollectionReference userCollection=Firestore.instance.collection('User');







  //user profile data from snapshot
  User _userProfileDataFromSnapshot(DocumentSnapshot snapshot){
    return User(
      userkey: snapshot.documentID,
      fullname: snapshot.data['fullname'],
      email: snapshot.data['email'],
      telenumber: snapshot.data['telenumber'],
      address: snapshot.data['address'],

    );
  }


//get user stream
  Stream<User> get profileData{
    return userCollection.document(this.uid).snapshots()
        .map(_userProfileDataFromSnapshot);
  }
  Future <List<DocumentSnapshot>>getSuggestions(String suggestion)=>
      userCollection.where('email',isGreaterThanOrEqualTo: suggestion).getDocuments().then((snap){
        return snap.documents;
      });
}