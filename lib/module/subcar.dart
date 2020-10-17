class SubCatergory {
  String subcatkey;
  String subcatergory;
  String catergory;
  String subcatergorysearchkey;
  String catergorykey;

  SubCatergory({this.subcatkey, this.subcatergory,this.catergory,this.subcatergorysearchkey,this.catergorykey});






  // new one



  SubCatergory.fromMap(Map<String, dynamic> data) {
    subcatkey = data['uid'];
    subcatergorysearchkey= data['subcatergorysearchkey'];
    catergory=data['catergory'];
    subcatergory=data['subcatergory'];
    catergorykey=data['catergorykey'];
  }

 Map<String, dynamic> toMap() {
    return {
      'uid': subcatkey,
      'subcatergorysearchkey': subcatergorysearchkey,
      'catergory':catergory,
      'subcatergory': subcatergory,
      'catergorykey':catergorykey,
    };
 }
}

