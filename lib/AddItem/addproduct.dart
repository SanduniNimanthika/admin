
import 'package:admin/AddItem/searchsub.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/AddItem/productcollection.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:admin/database/productdatabase.dart';



class AddProduct extends StatefulWidget {

  final String text;
  final String text2;
  final String catkey;
  final String subcatkey;

  AddProduct({Key key,@required this.text,@required this.text2,@required this.catkey,@required this.subcatkey}):super(key:key);
  @override
  _AddProductState createState() => _AddProductState(text: text,text2: text2,catkey: catkey,subcatkey: subcatkey);
}


class _AddProductState extends State<AddProduct> {
  bool loading = false;
  String error = '';
  String imgerror = '';
  String imgerror2 = '';
  String subcatergory;
  double offer;
String catergorykey;
String subcatergorykey;
  String productname;

  String type;
  int quntity;
  double price;
  String catergory;
  String description;
  double offerprice;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProductService _productService = ProductService();
  List<DocumentSnapshot> catergories = <DocumentSnapshot>[];
  File _image;

  String productsearchkey;

  final String text;
  final String text2;
  final String catkey;
  final String subcatkey;

  _AddProductState( {Key key, @required this.text, @required this.text2,@required this.catkey,@required this.subcatkey} );


  @override
  Widget build( BuildContext context ) {
    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height*2,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                            AssetImage("images/dashbord/backcat.jpg"),
                            fit: BoxFit.fill)),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height*2,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF185a9d),
                            const Color(0xFF43cea2)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: ( ) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ( context ) =>
                                    ProductCollection()));
                      },
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 15 * SizeConfig.heightMultiplier,
                                bottom: 5 * SizeConfig.heightMultiplier,
                                left: 6 * SizeConfig.heightMultiplier,
                                right: 6 * SizeConfig.heightMultiplier),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 3 * SizeConfig.heightMultiplier,bottom: 6*SizeConfig.heightMultiplier),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 6,
                                        child: Opacity(
                                          opacity: 0.8,
                                          child: Material(
                                            color: Colors.white,
                                            child: Container(
                                              height: 53,

                                              decoration: BoxDecoration(

                                                  border: Border.all(
                                                      color: Color(0xFF185a9d)
                                                  )
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0),
                                                child: Center(child: Row(
                                                  children: <Widget>[
                                                    Expanded(child: Text(
                                                      text2 == null
                                                          ? 'Search catergory'
                                                          : text2, style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .display1,)),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Opacity(
                                            opacity: 0.8,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(3.0),
                                                    child: Container(
                                                      height: 53,
                                                      //   width: 40,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF185a9d),
                                                          borderRadius: BorderRadius
                                                              .circular(12)
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(Icons.check,
                                                          color: Colors.white,),
                                                        onPressed: ( ) {
                                                          setState(( ) {
                                                            catergory =
                                                                text;
                                                            subcatergory =
                                                                text2;
                                                            catergorykey=catkey;
                                                            subcatergorykey=subcatkey;
                                                            print(subcatkey);
                                                            print(catkey);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(

                                                      height: 53,
                                                      //     width: 40,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .blueGrey,
                                                          borderRadius: BorderRadius
                                                              .circular(12)
                                                      ),

                                                      child: InkWell(
                                                          onTap: ( ) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context ) =>
                                                                        SearchSubCatergory()));
                                                          },
                                                          child: Icon(
                                                              Icons.search))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Center(
                                    child: Text(
                                      error,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                          color: Colors.red, fontSize: 15),
                                    )),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Opacity(
                                        opacity: .8,
                                        child: Padding(
                                          padding: EdgeInsets.only(right:8.0),
                                          child: Container(
                                            color: Colors.white,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 4,
                                            child: OutlineButton(
                                              onPressed: ( ) {
                                                // ignore: deprecated_member_use
                                                _selectImage(ImagePicker.pickImage(
                                                    source: ImageSource.gallery),
                                                    1);
                                              },
                                              child: _display1(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                Center(
                                    child: Text(
                                      imgerror,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                          color: Colors.red, fontSize: 15),
                                    )),


                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 6 * SizeConfig.heightMultiplier,bottom: 6*SizeConfig.heightMultiplier),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      child: new Center(
                                          child: new TextFormField(
                                              decoration: new InputDecoration(
                                                labelText: "Product Name",
                                                prefixIcon: Icon(Icons.add,
                                                    color: Colors.blueGrey),
                                                labelStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .display1,
                                                fillColor: Colors.white,
                                                filled: true,
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                              ),

                                              validator: (input) {
                                      Pattern pattern =
                                      r'^(?=.*?[A-Z])(?=.*?[a-z]).{2,}$';
                                      RegExp regex =
                                      new RegExp(pattern);
                                      if (input.isEmpty) {
                                      return 'Please provide a product name';
                                      } else {
                                      if (!regex.hasMatch(input))
                                      return 'You product name should be begin with capital letter';
                                      else
                                      return null;
                                      }
                                      },
                                              onChanged: ( input ) {
                                                setState(( ) {
                                                  productname = input;
                                                });
                                              },
                                              keyboardType: TextInputType.text,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: "Product Searchkey",
                                              prefixIcon: Icon(Icons.add,
                                                  color: Colors.blueGrey),
                                              labelStyle: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                            ),
                                            validator: ( input ) =>
                                            input
                                                .isEmpty
                                                ? 'Please type your product searchkey\n as first letter of the product name here'
                                                : null,
                                            onChanged: ( input ) {
                                              setState(( ) {
                                                productsearchkey = input;
                                                subcatergorykey=subcatkey;
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 6 * SizeConfig.heightMultiplier,bottom: 6*SizeConfig.heightMultiplier),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(

                                      child: new Center(
                                          child: new TextFormField(
                                              decoration: new InputDecoration(
                                                labelText: "Product Price",
                                                prefixIcon: Icon(Icons.add,
                                                    color: Colors.blueGrey),
                                                labelStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .display1,
                                                fillColor: Colors.white,
                                                filled: true,
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                              ),
                                              validator: ( input ) =>
                                              input
                                                  .isEmpty
                                                  ? 'Please type your product price here'
                                                  : null,
                                              onChanged: ( input ) {
                                                setState(( ) {
                                                  String prices = input;
                                                  price = double.parse(prices);
                                                });
                                              },
                                              keyboardType: TextInputType.number,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.8,
                                  child: Container(

                                    child: new Center(
                                        child: new TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: "Product Description",
                                              prefixIcon: Icon(Icons.add,
                                                  color: Colors.blueGrey),
                                              labelStyle: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,

                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                            ),
                                            validator: ( input ) =>
                                            input
                                                .isEmpty
                                                ? 'Please type your product description here'
                                                : null,
                                            onChanged: ( input ) {
                                              setState(( ) {
                                                description = input;
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            maxLines: 7,

                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                                Padding(
                                  padding:EdgeInsets.only(
                                      top: 6 * SizeConfig.heightMultiplier,bottom: 6*SizeConfig.heightMultiplier),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(

                                      child: new Center(
                                          child: new TextFormField(
                                              decoration: new InputDecoration(
                                                labelText: "Product Quntity",
                                                prefixIcon: Icon(Icons.add,
                                                    color: Colors.blueGrey),
                                                labelStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .display1,
                                                fillColor: Colors.white,
                                                filled: true,
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                              ),
                                              validator: ( input ) =>
                                              input
                                                  .isEmpty
                                                  ? 'Please type your product quntity here'
                                                  : null,
                                              onChanged: ( input ) {
                                                setState(( ) {
                                                  String quntitys = input;
                                                  quntity = int.parse(quntitys);
                                                });
                                              },
                                              keyboardType: TextInputType.number,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:EdgeInsets.only(
                                      bottom: 6*SizeConfig.heightMultiplier),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(

                                      child: new Center(
                                          child: new TextFormField(
                                              decoration: new InputDecoration(
                                                labelText: "Product Offer",
                                                prefixIcon: Icon(Icons.add,
                                                    color: Colors.blueGrey),
                                                labelStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .display1,
                                                fillColor: Colors.white,
                                                filled: true,
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),
                                              ),

                                              onChanged: ( input ) {
                                                setState(( ) {
                                                  String quntitys = input;
                                                  offer = double.parse(quntitys);
                                                  catergorykey=catkey;
                                                });
                                              },
                                              keyboardType: TextInputType.number,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),
                                ),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          "perscription",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        leading: Radio(
                                          value: 'perscription required',
                                          activeColor: Colors.white,
                                          groupValue: type,
                                          onChanged: ( input ) {
                                            setState(( ) {
                                              type = input;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          'non perscription',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        leading: Radio(
                                          value: 'nonperscription required',
                                          activeColor: Colors.white,
                                          groupValue: type,

                                          onChanged: ( input ) {
                                            setState(( ) {
                                              type = input;

                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),


                                Center(
                                    child: Text(
                                      imgerror2,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                          color: Colors.red, fontSize: 15),
                                    )),



                                // button
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10 * SizeConfig.heightMultiplier,
                                  ),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    elevation: 4.0,
                                    child: InkWell(
                                      onTap: ( ) async {
                                        if (_formKey.currentState
                                            .validate()) {
                                          setState(() {
                                            loading = true;
                                          });

                                          if (_image != null ) {
                                            if (type != null) {
                                              if (subcatergory != null) {

                                                String imageUrl;

                                                final FirebaseStorage storage = FirebaseStorage
                                                    .instance;
                                                final String picture = '1${DateTime
                                                    .now()
                                                    .millisecondsSinceEpoch
                                                    .toString()}.jpg';
                                                StorageUploadTask task = storage
                                                    .ref()
                                                    .child(picture)
                                                    .putFile(_image);

                                                StorageTaskSnapshot snapshot = await task
                                                    .onComplete.then((
                                                    snapshot ) => snapshot);
                                                task.onComplete.then((
                                                    snapshot ) async {
                                                  imageUrl =
                                                  await snapshot.ref
                                                      .getDownloadURL();



                                                  _productService
                                                      .createProductData(
                                                      productname,
                                                      catergory,
                                                      subcatergory,
                                                      type,
                                                      quntity,
                                                      price,
                                                      imageUrl,
                                                      description,
                                                      productsearchkey,
                                                    offer!=null?offer:0,
                                                      offer!=null? (price-(price*offer/100)):0,catergorykey,subcatergorykey

                                                  );


                                                  showDialog(
                                                      context: context,
                                                      builder: ( context ) {
                                                        return Dialog(
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20.0),
                                                          ),
                                                          child: Container(
                                                            height: 150.0,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                      top: 20.0),
                                                                  child: Text(
                                                                    "product is added",
                                                                    style: Theme
                                                                        .of(
                                                                        context)
                                                                        .textTheme
                                                                        .display1,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      30.0),
                                                                  child: Material(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        20.0),
                                                                    elevation: 4.0,
                                                                    child: InkWell(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          20.0),
                                                                      onTap: ( ) {
                                                                        Navigator
                                                                            .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (
                                                                                    context ) =>
                                                                                    ProductCollection()));
                                                                      },
                                                                      child:
                                                                      Container(
                                                                        height: 40.0,
                                                                        width: 100.0,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          gradient:
                                                                          LinearGradient(
                                                                            begin: Alignment
                                                                                .topLeft,
                                                                            end: Alignment
                                                                                .bottomRight,
                                                                            colors: [
                                                                              const Color(
                                                                                  0xFF185a9d),
                                                                              const Color(
                                                                                  0xFF43cea2)
                                                                            ],
                                                                          ),
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              20.0),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(
                                                                              "okay",
                                                                              style: Theme
                                                                                  .of(
                                                                                  context)
                                                                                  .textTheme
                                                                                  .subhead),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                });
                                              } else {
                                                setState(( ) {
                                                  error =
                                                  "please provide a subcatergory of product and click blue check button";
                                                  loading = false;
                                                });
                                              }
                                            } else {
                                              setState(( ) {
                                                imgerror2 =
                                                "please provide a type of product";
                                                loading = false;
                                              });
                                            }
                                          }
                                          else {
                                            setState(( ) {
                                              imgerror =
                                              "please provide a image";
                                              loading = false;
                                            });
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              const Color(0xFF185a9d),
                                              const Color(0xFF43cea2)
                                            ],
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                          child: Text("Save",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .subhead),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _selectImage( Future<File> pickImage, int imageNumber ) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1
          :
        setState(( ) => _image = tempImg);
        break;
    }
  }

  Widget _display1( ) {
    if (_image == null) {
      return Padding(
        padding: EdgeInsets.all(40),
        child: Icon(Icons.add),
      );
    } else {
      return Image.file(_image, fit: BoxFit.fill,);
    }
  }


}




