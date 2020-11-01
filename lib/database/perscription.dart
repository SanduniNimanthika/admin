import 'package:admin/order/perscriptionhistory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/notifer/perscriptionnotifer.dart';

import 'package:admin/module/perscriptionOrder.dart';



getPerscriptionOrderHistory(
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier) async {

  QuerySnapshot snapshot = await Firestore.instance
      .collection('PerscriptionOrder')
      .where('status',isEqualTo:'pending' )
      .orderBy("date", descending: false)
      .getDocuments();

  List<ProductPerscription> _perscriptionOrderHistoryList = [];

  snapshot.documents.forEach((document) {
    ProductPerscription perscriptionOrderHistory =
        ProductPerscription.fromMap(document.data);
    _perscriptionOrderHistoryList.add(perscriptionOrderHistory);
  });

  perscriptionOrderHistoryNotifier.perscriptionOrderHistoryList =
      _perscriptionOrderHistoryList;
}

getPerscriptionOrderHistorys(
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier,String useremail) async {

  QuerySnapshot snapshot = await Firestore.instance
      .collection('PerscriptionOrder')
      .where('email',isEqualTo:useremail )
      .orderBy("date", descending: false)
      .getDocuments();

  List<ProductPerscription> _perscriptionOrderHistoryList = [];

  snapshot.documents.forEach((document) {
    ProductPerscription perscriptionOrderHistory =
    ProductPerscription.fromMap(document.data);
    _perscriptionOrderHistoryList.add(perscriptionOrderHistory);
  });

  perscriptionOrderHistoryNotifier.perscriptionOrderHistoryList =
      _perscriptionOrderHistoryList;
}

uploadPerscriptionHistory(ProductPerscription productPerscription,Function productPerscriptionUpload)async{

  _uploadPerscriptionHistory(productPerscription,productPerscriptionUpload );

}

_uploadPerscriptionHistory(ProductPerscription productPerscription,/* bool isUpdating*/ Function orderHistoryUploaded) async {
  CollectionReference productPerscriptionHistoryCollection = Firestore.instance.collection('PerscriptionOrder');

  await productPerscriptionHistoryCollection.document(productPerscription.perscriptionkey).updateData(productPerscription.toMap());
  orderHistoryUploaded(productPerscription);


}
