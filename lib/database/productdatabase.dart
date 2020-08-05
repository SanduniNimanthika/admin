import 'package:admin/module/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  String ref='Product';
  final String uid;

  ProductService({
    this.uid,
  });

  //database collection
  final CollectionReference productCollection =
  Firestore.instance.collection('Product');


  Future createProductData(
  String productname,
  String catergory,
  String subcatergory,
  String type,
  int quntity,
  double price,
  List images,
  String description,
      String productsearchkey) async {
    String id = productCollection.document().documentID;
    return await productCollection.document(id).setData(
        {'uid': id, 'productname':productname,'catergory': catergory,
          'subcatergory': subcatergory,'type':type,'quntity':quntity,'price':price,'images':images,'description':description,' productsearchkey': productsearchkey,});
  }

}
