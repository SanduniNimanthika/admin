class ProductOrderHistory {
  String productcartkey;
  String productname;
  String userkey;
  String productkey;

  int quntity;
  double price;
  double fullprice;
  String images;
  String  fullname;
  String telenumber;
  String address;
  String status;
  String productOrderHistorykey;


  ProductOrderHistory(
      {this.productcartkey,
        this.productname,
        this.userkey,
        this.productkey,
        this.quntity,
        this.price,
        this.fullprice,
        this.images,
        this.address,
        this.telenumber,
        this.fullname,
        this.status,
        this.productOrderHistorykey});




  ProductOrderHistory.fromMap(Map<String, dynamic> data) {
    productcartkey = data['uid'];
    userkey=data['userkey'];
    productkey=data['productkey'];
    productname=data['productname'];

    quntity=data['quntity'];
    price=data['price'];
    fullprice=data['fullprice'];

    images=data['images'];
    fullname=data['fullname'];
    telenumber=data['telenumber'];
    address=data['address'];
    status=data['status'];
    productOrderHistorykey=data['productOrderHistorykey'];

  }

  Map<String, dynamic> toMap() {
    return {
      'uid': productcartkey,
      'productname': productname,
      'userkey': userkey,
      'productkey':productkey,
      'images': images,
      'quntity':quntity,
      'price':price,
      'fullprice':fullprice,
      'address':address,
      'fullname':fullname,
      'telenumber':telenumber,
      'status':status,
      'productOrderHistorykey':productOrderHistorykey,

    };
  }
}


