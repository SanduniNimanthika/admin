import 'dart:ui';
import 'package:admin/StoreDisplay/productdisplay.dart';
import 'package:admin/StoreDisplay/subcatergorylist.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/module/subcar.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:admin/database/subcatdatabse.dart';
import 'package:admin/notifer/subcatergorynotifier.dart';
import 'package:admin/notifer/catergorynotifer.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Productlist extends StatefulWidget {
  @override
  _ProductlistState createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  @override
  void initState() {
    SubCatergoryNotifier subcatergoryNotifier =
        Provider.of<SubCatergoryNotifier>(context, listen: false);
    getSubCatergories(subcatergoryNotifier);
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);

    super.initState();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context);
    SubCatergoryNotifier subcatergoryNotifier =
        Provider.of<SubCatergoryNotifier>(context);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);



    return SafeArea(
        child: Scaffold(
      key: _key,
      appBar: _customAppBar(
          _key,
          context,
           subcatergoryNotifier.currentSubCatergory.subcatergory,subcatergoryNotifier.currentSubCatergory.catergorykey
             ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: productNotifier.productList.length,
          itemBuilder: (BuildContext context, int index) {
            return (catergoryNotifier.currentCatergory.catergory ==
                        productNotifier.productList[index].catergory &&
                    subcatergoryNotifier.currentSubCatergory.subcatergory ==
                        productNotifier.productList[index].subcatergory)
                ? InkWell(
                    onTap: () {
                      productNotifier.currentProduct =
                          productNotifier.productList[index];
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ProductDisplay(back: 'page',);
                      }));
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                        child: Material(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0)),
                          elevation: 5,
                          shadowColor: Colors.greenAccent,
                          child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 9 * 2,
                              decoration:boxDecarationhistory(),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          decoration: boxDecarationhistory(),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          child: Stack(
                                            children: <Widget>[

                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(25.0),
                                                        bottomRight:
                                                            Radius.circular(25.0)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            productNotifier
                                                                .productList[index]
                                                                .images),
                                                        fit: BoxFit.fill)),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child:(productNotifier.productList[index].offer!=0) ?Container(
                                                  height: 37,
                                                  width: 57.0,
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
                                                ):Container()
                                              )
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      flex:3 ,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 8.0,top: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                productNotifier
                                                    .productList[index]
                                                    .productname,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead
                                                    .copyWith(
                                                        color:
                                                            Color(0xFF185a9d),
                                                        ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Text(
                                                  ' Rs: ${productNotifier
                                                      .productList[index]
                                                      .price
                                                      .toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("In Stock :  ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1.copyWith(fontSize: 14)),
                                                    Text(
                                                      productNotifier
                                                          .productList[index]
                                                          .quntity
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .display1
                                                          .copyWith(
                                                              color:
                                                                  Colors.red,fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        )),
                  )
                : Container();
          }),
      floatingActionButton: Flotinng()
    ));
  }
}


class Flotinng extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    SubCatergoryNotifier subcatergoryNotifier =
    Provider.of<SubCatergoryNotifier>(context);
   
    _onSubCatergoryDeleted(SubCatergory subcatergory) {
      Navigator.pop(context);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return SubCatergorylist();}));

      subcatergoryNotifier.deleteSubCatergory(subcatergory);
    }
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () {
        FirebaseAuth.instance.currentUser().then((user){
          Firestore.instance.collection("/Staff").
          where('uid',isEqualTo: user.uid).
          getDocuments().
          then((docs){
            if (docs.documents[0].exists) {
              if (docs.documents[0].data['role'] == 'admin'){
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              20.0),
                        ),
                        child: Container(
                          height: 300.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.warning,color: Colors.red,size: 30,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.all(
                                    20.0),
                                child: Text(
                                  "After you delete an SubCatergory, it's permanently deleted and all the products within subcatergory also deleted. SubCatergories can't be undeleted.",
                                  style: Theme.of(
                                      context)
                                      .textTheme
                                      .display1.copyWith(color: Colors.red,),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.all(
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
                                      onTap: () {
                                        Firestore.instance
                                            .collection('Product')
                                            .where("subcatergorykey",
                                            isEqualTo: subcatergoryNotifier.currentSubCatergory.subcatkey)
                                            .getDocuments()
                                            .then((querySnapshot) {

                                          querySnapshot.documents
                                              .forEach((result) {

                                            result.reference.delete();

                                          });
                                        });
                                        deleteSubCatergory(
                                            subcatergoryNotifier.currentSubCatergory, _onSubCatergoryDeleted);
                                      },
                                      child:buttonContainer(context, 'okey', 40, 150)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });

              }else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              20.0),
                        ),
                        child: Container(
                          height: 150.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                EdgeInsets.only(
                                    top: 20.0),
                                child: Text(
                                  "Only admin can delete",
                                  style: Theme.of(
                                      context)
                                      .textTheme
                                      .display1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsets.all(
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
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child:buttonContainer(context,'okey', 40, 100)

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
          });

        });

      },
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );

  }
}

Widget _customAppBar(GlobalKey<ScaffoldState> globalKey, BuildContext context,
    String subcatergoryname,String catname) {
  CatergoryNotifier catergoryNotifier =
  Provider.of<CatergoryNotifier>(context);
  return PreferredSize(
    preferredSize: Size.fromHeight(12 * SizeConfig.heightMultiplier),
    child: Material(
      elevation: 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: linearcolor()
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 2.2 * SizeConfig.widthMultiplier,
              right: 2.2 * SizeConfig.widthMultiplier),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 1 * SizeConfig.widthMultiplier,
                  right: 2.2 * SizeConfig.widthMultiplier),
              child: Row(
                children: <Widget>[

                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: catergoryNotifier.catergoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return (catname ==
                              catergoryNotifier.catergoryList[index].catkey)
                              ? Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                catergoryNotifier.currentCatergory =
                                catergoryNotifier.catergoryList[index];
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (BuildContext context) {
                                      return SubCatergorylist();
                                    }));
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                          )
                              : Container();
                        }),

                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: Text(
                              subcatergoryname,
                              style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                            )),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                   UserAccessSubCatEdit().authorizedAccess(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
