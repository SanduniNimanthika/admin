class SubCatergory {
  String subcatkey;
  String subcatergory;
  String catergory;

  String catergorykey;

  SubCatergory({this.subcatkey, this.subcatergory,this.catergory,this.catergorykey});






  // new one



  SubCatergory.fromMap(Map<String, dynamic> data) {
    subcatkey = data['uid'];

    catergory=data['catergory'];
    subcatergory=data['subcatergory'];
    catergorykey=data['catergorykey'];
  }

 Map<String, dynamic> toMap() {
    return {
      'uid': subcatkey,

      'catergory':catergory,
      'subcatergory': subcatergory,
      'catergorykey':catergorykey,
    };
 }
}

