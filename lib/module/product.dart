class Product {
  String productkey;
  String productname;
  String catergory;
  String subcatergory;
  String type;
  int quntity;
  double price;
  String description;
  List images;
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
}
