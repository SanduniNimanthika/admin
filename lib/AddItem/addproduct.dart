
import 'package:admin/AddItem/product.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:admin/database/productdatabase.dart';
import 'package:admin/StoreDisplay/productdisplay.dart';
import 'package:admin/module/product.dart';
import 'package:flutter/foundation.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:admin/database/subcatdatabse.dart';



class AddProduct extends StatefulWidget {

  final String text;


  AddProduct({Key key,@required this.text,}):super(key:key);
  @override
  _AddProductState createState() => _AddProductState(text: text,);
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
  bool capsualtype=false;
  double cardprice;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProductService _productService = ProductService();
  List<DocumentSnapshot> catergories = <DocumentSnapshot>[];
  File _image;
  File _imageFile;
  String _imageUrl;

  String productsearchkey;

  final String text;

  _AddProductState( {Key key, @required this.text, } );
  SubCatergoryService _subcategoryService = SubCatergoryService();
  Product _currentProduct;
  @override
  void initState() {
    super.initState();
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);

    if (productNotifier.currentProduct != null) {
      _currentProduct = productNotifier.currentProduct;
    } else {
      _currentProduct = Product();
    }
    _imageUrl = _currentProduct.images;
  }

  _onProductUploaded(Product product) {
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);
    productNotifier.addProduct(product);

  }


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
                      gradient: linearcolor()
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

                        if (text == "AddItem") {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Item()));
                        } else {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDisplay()));
                        }

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
                                top: 7 * SizeConfig.heightMultiplier,
                                bottom: 5 * SizeConfig.heightMultiplier,
                                left: 6 * SizeConfig.heightMultiplier,
                                right: 6 * SizeConfig.heightMultiplier),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 6 *
                                          SizeConfig.heightMultiplier,
                                      bottom: 3 *
                                          SizeConfig.heightMultiplier),
                                  child: Opacity(
                                    opacity: .8,
                                    child: TypeAheadField(
                                      textFieldConfiguration:
                                      TextFieldConfiguration(
                                        autofocus: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        decoration: InputDecoration(
                                          labelText: (text == "AddItem")
                                              ? (catergory ==
                                              null)
                                              ? "search by subcatertgory name"
                                              : catergory
                                              :_currentProduct.subcatergory ,
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          prefixIcon: Icon(Icons.search,
                                              color: Colors.blueGrey),
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
                                      ),
                                      suggestionsCallback:
                                          (pattern) async {
                                        return await _subcategoryService
                                            .getSuggestions(pattern);
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return Column(
                                          children: <Widget>[
                                            ListTile(
                                              leading:
                                              Icon(Icons.category),
                                              title: Text(
                                                suggestion['catergory'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1.copyWith(color: Colors.black),
                                              ),
                                              subtitle:  Text(
                                                suggestion['subcatergory'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            )
                                          ],
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        if (text == "AddItem") {
                                          setState(() {
                                            catergory =
                                            suggestion['catergory'];

                                            catergorykey =
                                            suggestion['catergorykey'];
                                            subcatergorykey= suggestion['uid'];
                                            subcatergory=suggestion['subcatergory'];
                                            print(
                                                suggestion['catergory']);
                                          });
                                        } else {
                                          setState(() {

                                            _currentProduct
                                                .catergory =
                                            suggestion['catergory'];

                                            _currentProduct.catergorykey =
                                            suggestion['catergorykey'];
                                            _currentProduct.subcatergorykey= suggestion['uid'];
                                            _currentProduct
                                                .subcatergory=suggestion['subcatergory'];
                                          });
                                        }
                                      },
                                    ),
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
                                (text=="AddItem")?
                                Opacity(
                                  opacity: .8,
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
                                ): _showImage(),
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
                                      top: 4 * SizeConfig.heightMultiplier,bottom: 4*SizeConfig.heightMultiplier),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      child: new Center(
                                          child: new TextFormField(
                                              initialValue:
                                              (text == "AddItem")
                                                  ? null
                                                  : _currentProduct.productname,
                                              decoration: inputDecaration(context, "Product Name",Icons.add),
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
                                                if(text=='AddItem'){
                                                setState(( ) {
                                                  productname = input;
                                                });
                                              }else{
                                                  _currentProduct.productname =
                                                      input;
                                                }},
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
                                          initialValue: (text == "AddItem")
                                              ? null
                                              : _currentProduct.price.toString(),
                                            decoration: inputDecaration(context, "Product Price", Icons.add),

                                            validator: ( input ) =>
                                            input
                                                .isEmpty
                                                ? 'Please type your product price here'
                                                : null,
                                            onChanged: ( input ) {
                                              if(text=='AddItem'){
                                                setState(( ) {
                                                  String prices = input;
                                                  price = double.parse(prices);
                                                });
                                              }else{
                                                setState(() {
                                                  String prices = input;
                                                  _currentProduct.price =
                                                      double.parse(prices);
                                                });
                                              }


                                            },
                                            keyboardType: TextInputType.number,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                                CheckboxListTile(
                                  title: Text("Capsual with card", style: Theme
                                      .of(context)
                                      .textTheme
                                      .subhead,),
                                  value: capsualtype,
                                  onChanged: (newValue) {
                                    if(text=='AddItem'){
                                      setState(() {
                                        capsualtype= newValue;
                                      });
                                    }else{
                                      setState(() {

                                        _currentProduct.capsualtype =newValue;
                                      });
                                    }

                                  },
                                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                ),
                                (capsualtype==true)? Opacity(
                                  opacity: 0.8,
                                  child: Container(

                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue: (text == "AddItem")
                                                ? null
                                                : _currentProduct.cardprice.toString(),
                                            decoration: inputDecaration(context, "Product CardPrice", Icons.add),
                                            onChanged: ( input ) {
                                              if(text=='AddItem'){
                                                setState(( ) {
                                                  String prices = input;
                                                  cardprice = double.parse(prices);
                                                });
                                              }else{
                                                setState(() {
                                                  String prices = input;
                                                  _currentProduct.cardprice =
                                                      double.parse(prices);
                                                });
                                              }


                                            },
                                            keyboardType: TextInputType.number,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ):Container(),



                                Opacity(
                                  opacity: 0.8,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 4 * SizeConfig.heightMultiplier,bottom: 4*SizeConfig.heightMultiplier),
                                    child: Container(

                                      child: new Center(
                                          child: new TextFormField(
                                              initialValue: (text == "AddItem")
                                                  ? null
                                                  : _currentProduct.description,
                                              decoration: inputDecaration(context, "Product Description",Icons.add),

                                              validator: ( input ) =>
                                              input
                                                  .isEmpty
                                                  ? 'Please type your product description here'
                                                  : null,
                                              onChanged: ( input ) {
                                                if(text=='AddItem'){
                                                  setState(( ) {
                                                    description = input;
                                                  });
                                                }else{
                                                  setState(() {

                                                    _currentProduct.description =
                                                        input;
                                                  });
                                                }

                                              },
                                              keyboardType: TextInputType.text,
                                              maxLines: 7,

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
                                            initialValue: (text == "AddItem")
                                                ? null
                                                : _currentProduct.quntity.toString(),
                                            decoration:inputDecaration(context,  "Product Quntity",Icons.add),
                                            validator: ( input ) =>
                                            input
                                                .isEmpty
                                                ? 'Please type your product quntity here'
                                                : null,
                                            onChanged: ( input ) {
                                              if(text=='AddItem'){
                                                setState(( ) {
                                                  String quntitys = input;
                                                  quntity = int.parse(quntitys);
                                                });
                                              }else{
                                                setState(() {

                                                  String quntitys = input;
                                                  _currentProduct.quntity = int.parse(quntitys);
                                                });
                                              }

                                            },
                                            keyboardType: TextInputType.number,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),

                                Padding(
                                   padding: EdgeInsets.only(
                                top: 4 * SizeConfig.heightMultiplier,bottom: 4*SizeConfig.heightMultiplier),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(

                                      child: new Center(
                                          child: new TextFormField(
                                            initialValue: (text == "AddItem")
                                                ? null
                                                : _currentProduct.offer.toString(),
                                              decoration: new InputDecoration(
                                                labelText: "Product Offer",
                                                suffixText: "%",suffixStyle:  Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1,
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
                                                if(text=='AddItem'){
                                                  setState(( ) {
                                                    String quntitys = input;
                                                    offer = double.parse(quntitys);

                                                  });
                                                }else{
                                                  setState(() {

                                                    String quntitys = input;
                                                    _currentProduct.offer =
                                                        double.parse(quntitys);
                                                  });
                                                }


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
                                            if(text=='AddItem'){
                                              setState(( ) {
                                                type = input;
                                              });
                                            }else{
                                              setState(() {
                                                _currentProduct.type = input;
                                              });
                                            }

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
                                            if(text=='AddItem'){
                                              setState(( ) {
                                                type = input;
                                              });
                                            }else{
                                              setState(() {
                                                _currentProduct.type = input;
                                              });
                                            }
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
                                          color: Colors.red, fontSize: 12),
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
                                       if(text=="AddItem"){ if (_formKey.currentState
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

                                                    offer!=null?offer:0,
                                                      offer!=null? (price-(price*offer/100)):0,catergorykey,subcatergorykey,cardprice,capsualtype

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
                                                                                    Item()));
                                                                      },
                                                                      child:buttonContainer(context, 'Okey', 43, 100),

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
                                                  "please provide a subcatergory of product";
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
                                        }}else{
                                         _currentProduct.offerprice=(_currentProduct.price-(_currentProduct.price*_currentProduct.offer/100));
                                         saveEdit();
                                       }
                                      },
                                      child:buttonContainerWithBlue(context,'Save',43,null)

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
  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("image placeholder");
    } else if (_imageFile != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[

          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 3,
          ),
          FlatButton(
              padding: EdgeInsets.all(16),
              color: Colors.black54,
              child: Text(
                'Change image',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () async {
                File imageFile =
                // ignore: deprecated_member_use
                await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxWidth: 400);

                if (imageFile != null) {
                  setState(() {
                    _imageFile = imageFile;
                  });
                }
              }),

        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[

          Container(

              height: MediaQuery.of(context).size.height / 3,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_imageUrl), fit: BoxFit.fill)),
              )),
          FlatButton(
              padding: EdgeInsets.all(16),
              color: Colors.black54,
              child: Text(
                'Change Image',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () async {
                File imageFile =
                // ignore: deprecated_member_use
                await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxWidth: 400);

                if (imageFile != null) {
                  setState(() {
                    _imageFile = imageFile;
                  });
                }
              })
        ],
      );
    }
  }

  saveEdit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    uploadProductAndImage(
        _currentProduct /*widget.isUpdating*/,
        _imageFile,_onProductUploaded
    );
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 150.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Product is updated",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 4.0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          // Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDisplay()));

                        },
                        child:buttonContainer(context, 'Okey', 40, 100)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
        child: Icon(Icons.camera_alt),
      );
    } else {
      return Image.file(_image, fit: BoxFit.fill,);
    }
  }


}




