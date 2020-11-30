import 'dart:ui';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/database/Catdatabase.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:admin/notifer/catergorynotifer.dart';
import 'package:admin/StoreDisplay/subcatergorylist.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/StoreDisplay/productdisplay.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  ProductService productService= ProductService();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> _listValues;
  List<DropdownMenuItem<String>> _items;
  @override
  void initState() {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context, listen: false);
    getCatergories(catergoryNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          // linear background
          child: Container(
              decoration: BoxDecoration(
                gradient: linearcolor()
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                          child: Text(
                            "Product catergories",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: catergoryNotifier.catergoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueGrey,
                                thickness: 0.5,
                              ),
                              ListTile(

                                title: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      catergoryNotifier.currentCatergory =
                                          catergoryNotifier
                                              .catergoryList[index];
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return SubCatergorylist();
                                      }));
                                    },
                                    child: Text(
                                        catergoryNotifier
                                            .catergoryList[index].catergory,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ],
              )),
        ),
        body: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
           // physics: ScrollPhysics(),
          children:<Widget> [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height/5 )*2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/dashbord/online-tablet-with-pills-capsules-blisters-glass-bottles-plastic-tubes_159446-35.jpg"),
                              fit: BoxFit.fill)),
                      height: (MediaQuery.of(context).size.height/5*2),
                      width: MediaQuery.of(context).size.width/3*2,

                    ),
                  ),

                  ClipPath(
                    clipper: ClippingPath(),
                    child: Opacity(
                      opacity: 0.7,
                      child: Container(
                        height:(MediaQuery.of(context).size.height/5*2 ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: linearcolor()
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: 3.5 * SizeConfig.heightMultiplier,
                        left: 2 * SizeConfig.heightMultiplier,
                        right: 2 * SizeConfig.heightMultiplier,
                    bottom: 20),
                    child: Column(

                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  UserManagment().authorizedAccess(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 25.0,
                                  color: Colors.white,
                                )),
                            IconButton(
                              icon: Icon(
                                Icons.list,
                                size: 28,
                                color: Color(0xFF185a9d),
                              ),
                              onPressed: () {
                                _key.currentState.openDrawer();
                              },
                            ),

                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Let's ",
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Shoping ",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Color(0xFF185a9d)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              child: TypeAheadField(
                                textFieldConfiguration:
                                TextFieldConfiguration(
                                  autofocus: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1,
                                  decoration: InputDecoration(
                                    labelText: "search by product name",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .display1,
                                    prefixIcon: Icon(Icons.search,
                                        color: Colors.blueGrey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide: BorderSide(
                                          color: Color(0xFF185a9d),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide: BorderSide(
                                          color: Color(0xFF185a9d),
                                          style: BorderStyle.solid,
                                          width: 1),
                                    ),
                                  ),

                                ),
                                suggestionsCallback:
                                    (pattern) async {
                                  return await productService
                                      .getSuggestions(pattern);
                                },
                                itemBuilder: (context, suggestion) {
                                  return Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading:Container(
                                          height:30,
                                          width: 30,
                                          child: Image(
                                            image: NetworkImage(
                                                suggestion['images']
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        title: Text(
                                          suggestion['productname'],
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

                                },
                              ),
                            ),
                          ),
                        ),
                      ],

                    ),

                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Offers",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              OfferDisplay(),
            ],
          ),]
        ),
      ),
    );
  }
}

class OfferDisplay extends StatefulWidget {
  @override
  _OfferDisplayState createState() => _OfferDisplayState();
}

class _OfferDisplayState extends State<OfferDisplay> {
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProductsOffer(productNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:
      MediaQuery.of(context).size.width /
    MediaQuery.of(context).size.height/0.70),
      itemCount: productNotifier.productList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: ()async{
            setState(() {
              productNotifier.currentProduct =
              productNotifier.productList[index];
            });

            Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ProductDisplay(back:'offer');
            }));},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
              shadowColor: Colors.greenAccent,
              elevation: 5,
              child: Container(
                  decoration:boxDecarationhistory(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                              decoration:boxDecarationhistory(),
                              width: MediaQuery.of(context).size.width /5*2,
                              height: MediaQuery.of(context).size.height /5,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(productNotifier
                                                .productList[index].images),
                                            fit: BoxFit.fill)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 30,
                                      width: 47.0,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              bottomRight: Radius.circular(25.0)),
                                          ),
                                      child: Center(
                                        child: Text( '${productNotifier.productList[index].offer.toString()}%',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead

                                    ),
                                      ),
                                    ),
                                  )],
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    productNotifier
                                        .productList[index].productname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(
                                            color: Color(0xFF185a9d),
                                            ),
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Rs.${productNotifier.productList[index].offerprice.toString()}',
                                        style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 14),
                                      ),
                                      Text(
                                        'Rs.${productNotifier.productList[index].price.toString()}',
                                        style: Theme.of(context).textTheme.display1.copyWith(decoration: TextDecoration.lineThrough ,fontSize: 14)
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}




class ClippingPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height );
    path.lineTo(size.width, size.height );
    path.lineTo(
      0.0,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldCliper) => false;
}