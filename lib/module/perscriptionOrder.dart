class ProductPerscription {
  String images;
  String fullname;
  String firstlineaddress;
  String hometown;
  String telenumber;
  String email;
  int days;
  String specialDescription;

  String perscriptionkey;
  String status;
  String date;

  ProductPerscription(

      {this.images,
        this.fullname,
        this.firstlineaddress,
        this.hometown,
        this.telenumber,
        this.email,

        this.days,
        this.specialDescription,

        this.perscriptionkey,
      this.status,
      this.date});




  ProductPerscription.fromMap(Map<String, dynamic> data) {
    perscriptionkey = data['uid'];
    images=data['images'];
    fullname= data['fullname'];
    firstlineaddress=data['firstlineaddress'];
    hometown=data['hometown'];
    telenumber=data['telenumber'];
    email=data['email'];
    days=data['days'];
    specialDescription=data['specialDescription'];

    status=data['status'];
    date=data['date'];

  }

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'uid': perscriptionkey,
      'fullname':fullname,

      'firstlineaddress': firstlineaddress,
      'hometown':hometown,
      'telenumber': telenumber,
      'email':email,


      'days': days,
      'specialDescription':specialDescription,
      'status':status,
      'date':date

    };

  }
}