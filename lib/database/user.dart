import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/user.dart';
import 'package:admin/notifer/usernotifer.dart';
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
      hometown: snapshot.data['hometown']

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



getUser(UserNotifier userNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('User')
      .getDocuments();

  List<User> _userList = [];

  snapshot.documents.forEach((document) {
    User user = User.fromMap(document.data)!=null?User.fromMap(document.data):null;
    _userList.add(user);
  });

  userNotifier.userList = _userList;
}