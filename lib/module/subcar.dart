class SubCatergory {
  String subcatkey;
  String subcatergory;
  String catergory;
  String subcatergorysearchkey;

  SubCatergory({this.subcatkey, this.subcatergory,this.catergory,this.subcatergorysearchkey});






  // new one



  SubCatergory.fromMap(Map<String, dynamic> data) {
    subcatkey = data['uid'];
    subcatergorysearchkey= data['subcatergorysearchkey'];
    catergory=data['catergory'];
    subcatergory=data['subcatergory'];
  }

 Map<String, dynamic> toMap() {
    return {
      'uid': subcatkey,
      'subcatergorysearchkey': subcatergorysearchkey,
      'catergory':catergory,
      'subcatergory': subcatergory,
    };
 }
}

