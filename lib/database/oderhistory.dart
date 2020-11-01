import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/oderhistory.dart';
import 'package:admin/notifer/oderhistorynotifer.dart';




getProductOrderHistory(ProductOrderHistoryNotifier productOrderHistoryNotifier) async {


  QuerySnapshot snapshot = await Firestore.instance
      .collection('SuccessFullOrders')
      .where('status',isEqualTo:'pending' )
      .orderBy("productname", descending: true)
      .getDocuments();

  List<ProductOrderHistory> _productOrderHistoryList = [];

  snapshot.documents.forEach((document) {
    ProductOrderHistory productOrderHistory = ProductOrderHistory.fromMap(document.data);
    _productOrderHistoryList.add(productOrderHistory);
  });

  productOrderHistoryNotifier.productOrderHistoryList = _productOrderHistoryList;
}

getProductOrderHistorys(ProductOrderHistoryNotifier productOrderHistoryNotifier,String useruid) async {


  QuerySnapshot snapshot = await Firestore.instance
      .collection('SuccessFullOrders')
      .where('userkey',isEqualTo:useruid )
      .orderBy("productname", descending: true)
      .getDocuments();

  List<ProductOrderHistory> _productOrderHistoryList = [];

  snapshot.documents.forEach((document) {
    ProductOrderHistory productOrderHistory = ProductOrderHistory.fromMap(document.data);
    _productOrderHistoryList.add(productOrderHistory);
  });

  productOrderHistoryNotifier.productOrderHistoryList = _productOrderHistoryList;
}


uploadOrderHistory(ProductOrderHistory productOrderHistory,Function orderHistoryUploaded)async{

  _uploadOrderHistory(productOrderHistory,orderHistoryUploaded );

}

_uploadOrderHistory(ProductOrderHistory productOrderHistory,/* bool isUpdating*/ Function orderHistoryUploaded) async {
  CollectionReference productOrderHistoryCollection = Firestore.instance.collection('SuccessFullOrders');

  await productOrderHistoryCollection.document(productOrderHistory.productOrderHistorykey).updateData(productOrderHistory.toMap());
  orderHistoryUploaded(productOrderHistory);


}
