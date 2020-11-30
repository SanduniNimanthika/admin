class User{
  String userkey;
  String fullname;
  String email;
  String telenumber;
  String address;
String hometown;
  User({this.userkey,this.fullname,this.email,this.telenumber,this.address,this.hometown});

  User.fromMap(Map<String, dynamic> data) {
    userkey=data['uid'];
    email=data['email'];
    fullname=data['fullname'];
    address=data['address'];
    telenumber=data['telenumber'];
    hometown=data['hometown'];

  }

  Map<String, dynamic> toMap() {
    return {
      'uid':userkey,
      'email':email,
      'fullname':fullname,
      'address':address,
      'telenumber':telenumber,
      'hometown':hometown,
    };
  }
}