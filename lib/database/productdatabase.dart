import 'package:admin/module/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  String ref = 'Product';
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
      String images,
      String description,
      String productsearchkey,
      double offer,
      double offerprice,
      String catergorykey,
      String subcatergorykey) async {
    String id = productCollection.document().documentID;
    return await productCollection.document(id).setData({
      'uid': id,
      'productname': productname,
      'catergory': catergory,
      'subcatergory': subcatergory,
      'type': type,
      'quntity': quntity,
      'price': price,
      'images': images,
      'description': description,
      ' productsearchkey': productsearchkey,
      'offer':offer,
      'offerprice':offerprice,
      'catergorykey':catergorykey,
      'subcatergorykey':subcatergorykey,
    });
  }
}

getProducts(ProductNotifier productNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Product')
      .orderBy("productname", descending: false)
      .getDocuments();

  List<Product> _productList = [];

  snapshot.documents.forEach((document) {
    Product product = Product.fromMap(document.data);
    _productList.add(product);
  });

  productNotifier.productList = _productList;
}


getProductsOffer(ProductNotifier productNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Product').where('offer',isGreaterThan: 0.0)

      .getDocuments();

  List<Product> _productList = [];

  snapshot.documents.forEach((document) {
    Product product = Product.fromMap(document.data);
    _productList.add(product);
  });

  productNotifier.productList = _productList;
}



uploadProductAndImage(Product product /*,bool isUpdating*/, File localFile,
    Function productUploaded) async {
   if (localFile != null) {
  print("uploading image");

  var fileExtension = path.extension(localFile.path)!=null?path.extension(localFile.path):null;
  print(fileExtension);

  var uuid = Uuid().v4();

  final StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('$uuid$fileExtension');

  await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
    print(onError);
    return false;
  });
  String imageUrl;

  imageUrl = await firebaseStorageRef.getDownloadURL();

  print("download url: $imageUrl");
  _uploadProduct(product, productUploaded, /*isUpdating*/ imageUrl: imageUrl);
}else {
     print('...skipping image upload');
     _uploadProduct(product, productUploaded);
   }
}

_uploadProduct(Product product, /* bool isUpdating*/ Function productUploaded,
    {String imageUrl}) async {
  CollectionReference productCollection =
      Firestore.instance.collection('Product');

  if (imageUrl != null) {
    product.images = imageUrl;
  }

  await productCollection
      .document(product.productkey)
      .updateData(product.toMap());
  productUploaded(product);

  print('updated product with id: ${product.productkey}');
}

deleteProduct(Product product, Function productDeleted) async {
  if (product.images != null) {
    StorageReference storageReference =
        await FirebaseStorage.instance.getReferenceFromUrl(product.images);

    print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await Firestore.instance
      .collection('Product')
      .document(product.productkey)
      .delete();
  productDeleted(product);
}
