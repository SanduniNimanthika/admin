class Catergory {
  String catkey;
  String catergory;
  String catergorysearchkey;

  Catergory({this.catkey, this.catergory,this.catergorysearchkey});




                               // new one



  Catergory.fromMap(Map<String, dynamic> data) {
    catkey = data['uid'];
    catergorysearchkey= data['catergorysearchkey'];
    catergory=data['catergory'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid':catkey,
      'catergorysearchkey':catergorysearchkey,
      'catergory':catergory
    };
  }
}

