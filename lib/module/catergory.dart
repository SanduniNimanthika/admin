class Catergory {
  String catkey;
  String catergory;


  Catergory({this.catkey, this.catergory,});




                               // new one



  Catergory.fromMap(Map<String, dynamic> data) {
    catkey = data['uid'];

    catergory=data['catergory'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid':catkey,

      'catergory':catergory
    };
  }
}

