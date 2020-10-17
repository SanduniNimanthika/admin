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
  String productsearchkey;
  double offer;
  double offerprice;
  String catergorykey;
  String subcatergorykey;

  Product(
      {this.productkey,
      this.productname,
      this.catergory,
      this.subcatergory,
      this.type,
      this.quntity,
      this.price,
      this.description,
      this.images, this.productsearchkey,this.offer,this.offerprice,this.catergorykey,this.subcatergorykey});




  Product.fromMap(Map<String, dynamic> data) {
    productkey = data['uid'];
    productsearchkey= data['productsearchkey'];
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
  }

 Map<String, dynamic> toMap() {
    return {
      'uid': productkey,
       'productsearchkey':productsearchkey,
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
    };
 }
}


