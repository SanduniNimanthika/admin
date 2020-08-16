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

  Product(
      {this.productkey,
      this.productname,
      this.catergory,
      this.subcatergory,
      this.type,
      this.quntity,
      this.price,
      this.description,
      this.images, this.productsearchkey});




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
      'description':description
    };
 }
}


