import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/staff.dart';


class DatabaseService{
  final String uid;

  DatabaseService({this.uid,});


  //database collection
  final CollectionReference staffCollection=Firestore.instance.collection('Staff');

  Future updateStaffData( String fullname,
      String email,
      String telenumber,
      String address,)async{
    return await staffCollection.document(uid).setData({
      'uid':uid,
      'fullname':fullname,
      'email':email,
      'telenumber':telenumber,
      'address':address,
    });

  }





  //staff profile data from snapshot
  Staff _staffProfileDataFromSnapshot(DocumentSnapshot snapshot){
    return Staff(
      staffkey: snapshot.documentID,
      fullname: snapshot.data['fullname'],
      email: snapshot.data['email'],
      telenumber: snapshot.data['telenumber'],
      address: snapshot.data['address'],

    );
  }


//get staff stream
  Stream<Staff> get profileData{
    return staffCollection.document(this.uid).snapshots()
        .map(_staffProfileDataFromSnapshot);
  }
}



