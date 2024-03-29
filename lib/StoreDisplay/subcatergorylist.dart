import 'dart:ui';
import 'package:admin/AddItem/product.dart';
import 'package:admin/StoreDisplay/store.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/StoreDisplay/productlist.dart';
import 'package:admin/module/catergory.dart';
import 'package:admin/database/Catdatabase.dart';
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
import 'package:admin/StoreDisplay/productdisplay.dart';



class SubCatergorylist extends StatefulWidget {
  @override
  _SubCatergorylistState createState() => _SubCatergorylistState();
}

class _SubCatergorylistState extends State<SubCatergorylist> {
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
          catergoryNotifier.currentCatergory.catergory != null
              ? catergoryNotifier.currentCatergory.catergory
              : null,
        ),
        drawer: Drawer(
          // linear background
          child: Container(
              decoration: BoxDecoration(
                gradient:linearcolor()
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        child: Text(
                          catergoryNotifier.currentCatergory.catergory,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: subcatergoryNotifier.subcatergoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (catergoryNotifier.currentCatergory.catergory ==
                              subcatergoryNotifier
                                  .subcatergoryList[index].catergory) {
                            return Column(
                              children: <Widget>[
                                Divider(
                                  color: Colors.blueGrey,
                                  thickness: 1,
                                ),
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        subcatergoryNotifier
                                                .currentSubCatergory =
                                            subcatergoryNotifier
                                                .subcatergoryList[index];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return Productlist();
                                        }));
                                      },
                                      child: Text(
                                          subcatergoryNotifier
                                              .subcatergoryList[index]
                                              .subcatergory,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ],
              )),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: productNotifier.productList.length,
            itemBuilder: (BuildContext context, int index) {
              return(catergoryNotifier.currentCatergory.catergory ==
                  productNotifier.productList[index].catergory)
                  ?
                    InkWell(
                        onTap: () {
                          productNotifier.currentProduct =
                              productNotifier.productList[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ProductDisplay();
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
                                  decoration: boxDecarationhistory(),
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

                : Container(
              width: 0,
              height: 0,
              );
          }
        ),

        floatingActionButton: Floting()

      ),
    );
  }
}


class Floting extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
    Provider.of<CatergoryNotifier>(context);
    _onCatergoryDeleted(Catergory catergory) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Store()));}
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
                                  "After you delete an Catergory, it's permanently deleted and all the products within catergory also deleted. Catergories can't be undeleted.",
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
                                        deleteCatergory(
                                            catergoryNotifier.currentCatergory, _onCatergoryDeleted);
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
                                    child:buttonContainer(context, 'okey', 40, 150)
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


Widget _customAppBar(
  GlobalKey<ScaffoldState> globalKey,
  BuildContext context,
  String catergoryname,
) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
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
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Store()));

                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.list,
                      color: Colors.white,

                    ),
                    onPressed: () {
                      globalKey.currentState.openDrawer();
                    },
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 2.2 * SizeConfig.widthMultiplier,
                        right: 2.2 * SizeConfig.widthMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: Text(
                              catergoryname,
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
                                    UserAccessEdit().authorizedAccess(context);
                                   // Navigator.of(context).push(
                                   //     MaterialPageRoute(
                                     //       builder: (BuildContext context) {
                                   //   return EditCatergory();
                                  //  }));
                                  },
                                ),
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
          ),
        ),
      ),
    ),
  );
}
