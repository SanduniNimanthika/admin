import 'package:admin/module/subcar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubCatergoryService {
  final String uid;

  SubCatergoryService({
    this.uid,
  });

  //database collection
  final CollectionReference subcatergoryCollection =
      Firestore.instance.collection('SubCatergory');

  Future createSubCatData(String subcatergory, String catergory,
      String subcatergorysearchkey) async {
    String id = subcatergoryCollection.document().documentID;
    return await subcatergoryCollection.document(id).setData({
      'uid': id,
      'subcatergory': subcatergory,
      'catergory': catergory,
      'subcatergorysearchkey': subcatergorysearchkey
    });
  }

  Future subcatergoryupdate(String subcatergory) async {
    String id = subcatergoryCollection.document().documentID;
    return subcatergoryCollection
        .document(uid)
        .updateData({'uid': id, 'subcatergory': subcatergory});
  }


  // data from snapshot
  List<SubCatergory> _subcatergoryDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return SubCatergory(
        subcatkey: doc.documentID,
        subcatergorysearchkey: doc.data['subcatergorysearchkey'],
        subcatergory: doc.data['subcatergory']??'',
        catergory: doc.data['catergory']

      );
    }).toList();}

//get stream
  Stream<List<SubCatergory>> get subcatergory{
    return subcatergoryCollection
        .snapshots()
        .map(_subcatergoryDataFromSnapshot);
  }


}
