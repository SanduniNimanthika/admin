class Product {
  String productkey;
  String productname;
  String catergory;
  String subcatergory;
  String type;
  int quntity;
  double price;
  String description;
  String images;
  double offer;
  double offerprice;
  String catergorykey;
  String subcatergorykey;
  double cardprice;
  bool capsualtype;

  Product(
      {this.productkey,
      this.productname,
      this.catergory,
      this.subcatergory,
      this.type,
      this.quntity,
      this.price,
      this.description,
      this.images,this.offer,this.offerprice,this.catergorykey,this.subcatergorykey,this.cardprice,
      this.capsualtype});




  Product.fromMap(Map<String, dynamic> data) {
    productkey = data['uid'];

    catergory=data['catergory'];
    subcatergory=data['subcatergory'];
    productname=data['productname'];
    type=data['type'];
    quntity=data['quntity'];
    price=data['price'];
    description=data['description'];
    images=data['images'];
    offer=data['offer'];
     offerprice=data['offerprice'];
     catergorykey=data['catergorykey'];
     subcatergorykey=data['subcatergorykey'];
     cardprice=data['cardprice'];
     capsualtype=data['capsualtype'];
  }

 Map<String, dynamic> toMap() {
    return {
      'uid': productkey,

      'productname': productname,
      'catergory': catergory,
    'subcatergory':subcatergory,
      'images': images,
      'type': type,
      'quntity':quntity,
      'price':price,
      'description':description,
      'offer':offer,
      'offerprice':offerprice,
      'catergorykey':catergorykey,
      'subcatergorykey':subcatergorykey,
      'cardprice':cardprice,
      'capsualtype':capsualtype
    };
 }
}


