import 'package:admin/StoreDisplay/productdisplay.dart';
import 'package:admin/StoreDisplay/subcatergorylist.dart';
import 'package:admin/module/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:provider/provider.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:admin/StoreDisplay/searcheditsubcatergory.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Editproduct extends StatefulWidget {
  final bool isUpdating;
  final String text;
  final String catkey;
  final String subcatkey;
  final String text2;

  Editproduct(
      {Key key,
      @required this.text,
      @required this.text2,
      @required this.isUpdating,@required this.catkey,@required this.subcatkey})
      : super(key: key);
  @override
  _EditproductState createState() => _EditproductState(
        text: text,
        text2: text2,
    catkey: catkey,
    subcatkey: subcatkey
      );
}

class _EditproductState extends State<Editproduct> {
  Product _currentProduct;

  File _imageFile;
  String _imageUrl;

  bool loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String text;
  final String subcatkey;
  final String text2;
  final bool isUpdating;
  final String catkey;

  _EditproductState(
      {Key key,
      @required this.text,
      @required this.text2,
      @required this.isUpdating,
        @required this.catkey,@required this.subcatkey});
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("images/dashbord/backcat.jpg"),
                                fit: BoxFit.fill)),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          height: MediaQuery.of(context).size.height*2,
                          width: MediaQuery.of(context).size.width,
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
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                               context,
                             MaterialPageRoute(
                                 builder: (context) =>
                                     ProductDisplay()));
                          },
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 12 * SizeConfig.heightMultiplier,
                              bottom: 5 * SizeConfig.heightMultiplier,
                              left: 6 * SizeConfig.heightMultiplier,
                              right: 6 * SizeConfig.heightMultiplier),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 2 * SizeConfig.heightMultiplier,
                                    bottom: 6 * SizeConfig.heightMultiplier),
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
                                                    color: Color(0xFF185a9d))),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Center(
                                                  child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Text(
                                                    text2 == null
                                                        ? _currentProduct.subcatergory
                                                        : text2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .display1,
                                                  )),
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
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Container(
                                                    height: 53,
                                                    //   width: 40,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF185a9d),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _currentProduct
                                                              .catergory = text;
                                                          _currentProduct
                                                                  .subcatergory =
                                                              text2;
                                                          _currentProduct.catergorykey=catkey;
                                                          _currentProduct.subcatergorykey=subcatkey;
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
                                                        color: Colors.blueGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditSearchSubCatergory()));
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
                              _showImage(),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 6 * SizeConfig.heightMultiplier,
                                    bottom: 6 * SizeConfig.heightMultiplier),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue:
                                                _currentProduct.productname,
                                            decoration: new InputDecoration(
                                              labelText: "Product Name",
                                              prefixIcon: Icon(Icons.add,
                                                  color: Colors.blueGrey),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
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
                                            onChanged: (input) {
                                              setState(() {
                                                _currentProduct.productname =
                                                    input;
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            style: Theme.of(context)
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
                                          initialValue:
                                              _currentProduct.productsearchkey,
                                          decoration: new InputDecoration(
                                            labelText: "Product Searchkey",
                                            prefixIcon: Icon(Icons.add,
                                                color: Colors.blueGrey),
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            fillColor: Colors.white,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF185a9d),
                                                  style: BorderStyle.solid,
                                                  width: 1),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF185a9d),
                                                  style: BorderStyle.solid,
                                                  width: 1),
                                            ),
                                          ),
                                          validator: (input) => input.isEmpty
                                              ? 'Please type your product searchkey\n as first letter of the product name here'
                                              : null,
                                          onChanged: (input) {
                                            setState(() {
                                              _currentProduct.productsearchkey =
                                                  input;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 6 * SizeConfig.heightMultiplier,
                                    bottom: 6 * SizeConfig.heightMultiplier),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue: _currentProduct.price
                                                .toString(),
                                            decoration: new InputDecoration(
                                              labelText: "Product Price",
                                              prefixIcon: Icon(Icons.add,
                                                  color: Colors.blueGrey),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                            ),
                                            validator: (input) => input.isEmpty
                                                ? 'Please type your product price here'
                                                : null,
                                            onChanged: (input) {
                                              setState(() {
                                                String prices = input;
                                                _currentProduct.price =
                                                    double.parse(prices);
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            style: Theme.of(context)
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
                                          initialValue:
                                              _currentProduct.description,
                                          decoration: new InputDecoration(
                                            labelText: "Product Description",
                                            prefixIcon: Icon(Icons.add,
                                                color: Colors.blueGrey),
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            fillColor: Colors.white,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF185a9d),
                                                  style: BorderStyle.solid,
                                                  width: 1),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFF185a9d),
                                                  style: BorderStyle.solid,
                                                  width: 1),
                                            ),
                                          ),
                                          validator: (input) => input.isEmpty
                                              ? 'Please type your product description here'
                                              : null,
                                          onChanged: (input) {
                                            setState(() {
                                              _currentProduct.description =
                                                  input;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          maxLines: 7,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 6 * SizeConfig.heightMultiplier,
                                    bottom: 6 * SizeConfig.heightMultiplier),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue: _currentProduct
                                                .quntity
                                                .toString(),
                                            decoration: new InputDecoration(
                                              labelText: "Product Quntity",
                                              prefixIcon: Icon(Icons.add,
                                                  color: Colors.blueGrey),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                            ),
                                            validator: (input) => input.isEmpty
                                                ? 'Please type your product quntity here'
                                                : null,
                                            onChanged: (input) {
                                              setState(() {
                                                String quntitys = input;
                                                _currentProduct.quntity =
                                                    int.parse(quntitys);
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(

                                    bottom: 6 * SizeConfig.heightMultiplier),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Container(
                                    child: new Center(
                                        child: new TextFormField(
                                            initialValue: _currentProduct.offer.toString()
                                                ,
                                            decoration: new InputDecoration(
                                              labelText: "Product Offer",
                                              prefixIcon: Icon(Icons.add,
                                                  color: Colors.blueGrey),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                              ),
                                            ),

                                            onChanged: (input) {
                                              setState(() {
                                                String quntitys = input;
                                                _currentProduct.offer =
                                                    double.parse(quntitys);


                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            style: Theme.of(context)
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
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                      leading: Radio(
                                        value: 'perscription required',
                                        activeColor: Colors.white,
                                        groupValue: _currentProduct.type,
                                        onChanged: (input) {
                                          setState(() {
                                            _currentProduct.type = input;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        'non perscription',
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                      leading: Radio(
                                        value: 'nonperscription required',
                                        activeColor: Colors.white,
                                        groupValue: _currentProduct.type,
                                        onChanged: (input) {
                                          setState(() {
                                            _currentProduct.type = input;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10 * SizeConfig.heightMultiplier,
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  elevation: 4.0,
                                  child: InkWell(
                                    onTap: () async {
                                      print(_currentProduct.price);
                                      _currentProduct.offerprice=(_currentProduct.price-(_currentProduct.price*_currentProduct.offer/100));
                                      saveEdit();

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
                                            style: Theme.of(context)
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
                    ]),
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
                        child: Container(
                          height: 40.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF185a9d),
                                const Color(0xFF43cea2)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text("okay",
                                style: Theme.of(context).textTheme.subhead),
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
  }
}
