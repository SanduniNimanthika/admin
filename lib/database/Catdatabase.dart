import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/catergory.dart';

class CatergoryService {
  final String uid;

  CatergoryService({
    this.uid,
  });

  //database collection
  final CollectionReference catergoryCollection =
      Firestore.instance.collection('Catergory');


   //setdata
  Future createCatData(String catergory,String catergorysearchkey) async {
    String id = catergoryCollection.document().documentID;
    return await catergoryCollection
        .document(id)
        .setData({'uid': id, 'catergory': catergory,'catergorysearchkey':catergorysearchkey});
  }


  //updatedate
  Future catupdate(String catergory) async {
    String id = catergoryCollection.document().documentID;
    return catergoryCollection
        .document(uid)
        .updateData({'uid': id, 'catergory': catergory});
  }

  // data from snapshot
  List<Catergory> _catergoryDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
     return Catergory(
       catkey: doc.documentID,
       catergorysearchkey: doc.data['catergorysearchkey'],
       catergory: doc.data['catergory']??'',

    );
  }).toList();}

//get stream
  Stream<List<Catergory>> get catergory {
    return catergoryCollection
        .snapshots()
        .map(_catergoryDataFromSnapshot);
  }

}
