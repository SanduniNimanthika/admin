import 'package:admin/module/subcar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/notifer/subcatergorynotifier.dart';

class SubCatergoryService {
  final String uid;

  SubCatergoryService({
    this.uid,
  });

  //database collection
  final CollectionReference subcatergoryCollection =
      Firestore.instance.collection('SubCatergory');

  Future createSubCatData(String subcatergory, String catergory,
      String subcatergorysearchkey,String catergorykey) async {
    String id = subcatergoryCollection.document().documentID;
    return await subcatergoryCollection.document(id).setData({
      'uid': id,
      'subcatergory': subcatergory,
      'catergory': catergory,
      'subcatergorysearchkey': subcatergorysearchkey,
      'catergorykey':catergorykey
    });
  }

}



getSubCatergories(SubCatergoryNotifier subcatergoryNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('SubCatergory')

      .orderBy("subcatergory", descending:true)
      .getDocuments();

  List<SubCatergory> _subcatergoryList = [];

  snapshot.documents.forEach((document) {
    SubCatergory subcatergory = SubCatergory.fromMap(document.data);
    _subcatergoryList.add(subcatergory);
  });

  subcatergoryNotifier.subcatergoryList =  _subcatergoryList;
}


uploadSubCatergory(SubCatergory subcatergory,Function subcatergoryUploaded)async{



  _uploadSubCatergory(subcatergory,subcatergoryUploaded );
}

_uploadSubCatergory(SubCatergory subcatergory,/* bool isUpdating*/ Function subcatergoryUploaded) async {
  CollectionReference subcatergoryCollection = Firestore.instance.collection('SubCatergory');

  await subcatergoryCollection.document(subcatergory.subcatkey).updateData(subcatergory.toMap());
  subcatergoryUploaded(subcatergory);


}



deleteSubCatergory(SubCatergory subcatergory, Function subcatergoryDeleted) async {

  await Firestore.instance.collection('SubCatergory').document(subcatergory.subcatkey).delete();
  subcatergoryDeleted(subcatergory);
}