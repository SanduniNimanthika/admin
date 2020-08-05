import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/staff.dart';


class DatabaseService{
  final String uid;

  DatabaseService({this.uid,});


  //database collection
  final CollectionReference staffCollection=Firestore.instance.collection('Staff');

  Future updateStaffData(
      String email, String role,String fullname,String address,String telenumber )async{
    return await staffCollection.document(uid).setData({
      'uid':uid,
      'email':email,
      'role':role,
      'fullname':fullname,
      'address':address,
      'telenumber':telenumber,


    });


  }
Future profileupdate(
    String email,String role,
    String fullname,String address,String telenumber
    )async{
    return staffCollection.document(uid).updateData({
      'uid':uid,
      'email':email,
      'role':role,
      'fullname':fullname,
      'address':address,
      'telenumber':telenumber,


    });
}




  //staff profile data from snapshot
  Staff _staffProfileDataFromSnapshot(DocumentSnapshot snapshot){
    return Staff(
      staffkey: snapshot.documentID,
      role: snapshot.data['role'],
      email: snapshot.data['email'],
      fullname: snapshot.data['fullname'],
      address: snapshot.data['address'],
      telenumber: snapshot.data['telenumber']




    );
  }


//get staff stream
  Stream<Staff> get profileData{
    return staffCollection.document(this.uid).snapshots()
        .map(_staffProfileDataFromSnapshot);
  }
}



