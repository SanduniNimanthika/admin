class Staff{
  String staffkey;
 String role;
  String email;
  String fullname;
  String address;
  String telenumber;




  Staff({this.staffkey,this.role,this.email,this.fullname,this.address,this.telenumber});

  Staff.fromMap(Map<String, dynamic> data) {
   staffkey=data['uid'];
   role= data['role'];
   email=data['email'];
   fullname=data['fullname'];
   address=data['address'];
   telenumber=data['telenumber'];

  }

  Map<String, dynamic> toMap() {
   return {
    'uid':staffkey,
    'email':email,
    'role':role,
    'fullname':fullname,
    'address':address,
    'telenumber':telenumber,
   };
  }
}