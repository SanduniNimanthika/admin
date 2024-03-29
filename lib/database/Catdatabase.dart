import 'package:admin/notifer/catergorynotifer.dart';
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
  Future createCatData(String catergory,) async {
    String id = catergoryCollection.document().documentID;
    return await catergoryCollection
        .document(id)
        .setData({'uid': id, 'catergory': catergory,});
  }

  Future <List<DocumentSnapshot>>getSuggestions(String suggestion)=>
      catergoryCollection.where('catergory',isGreaterThanOrEqualTo: suggestion).getDocuments().then((snap){
        return snap.documents;
      });

}


getCatergories(CatergoryNotifier catergoryNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Catergory')
      .orderBy("catergory", descending:false)
      .getDocuments();

  List<Catergory> _catergoryList = [];

  snapshot.documents.forEach((document) {
    Catergory catergory = Catergory.fromMap(document.data)!=null?Catergory.fromMap(document.data):null;
    _catergoryList.add(catergory);
  });

  catergoryNotifier.catergoryList = _catergoryList;
}


uploadCatergory(Catergory catergory,Function catergoryUploaded)async{

  _uploadCatergory(catergory,catergoryUploaded );

}

_uploadCatergory(Catergory catergory,/* bool isUpdating*/ Function catergoryUploaded) async {
  CollectionReference catergoryCollection = Firestore.instance.collection('Catergory');

  await catergoryCollection.document(catergory.catkey).updateData(catergory.toMap());
  catergoryUploaded(catergory);


}



deleteCatergory(Catergory catergory, Function catergoryDeleted) async {


  await Firestore.instance.collection('Catergory').document(catergory.catkey).delete();
  catergoryDeleted(catergory);
}