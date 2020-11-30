import 'package:admin/StoreDisplay/productlist.dart';
import 'package:admin/StoreDisplay/store.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/module/product.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/material.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/notifer/subcatergorynotifier.dart';
import 'package:admin/database/subcatdatabse.dart';
import 'package:admin/notifer/catergorynotifer.dart';
import 'package:admin/database/Catdatabase.dart';

class ProductDisplay extends StatefulWidget {
  final String back;
  ProductDisplay({Key key, @required this.back}) : super(key: key);
  @override
  _ProductDisplayState createState() => _ProductDisplayState(back: back);
}

final int _numpage = 1;
final PageController _pageController = PageController(initialPage: 0);
int _currentpage = 0;

List<Widget> _buildPageIndicator() {
  List<Widget> list = [];
  for (int i = 0; i <= _numpage; i++) {
    list.add(i == _currentpage ? _indicator(true) : _indicator(false));
  }
  return list;
}

Widget _indicator(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    height: 1.5 * SizeConfig.heightMultiplier,
    width: isActive
        ? 20 * SizeConfig.heightMultiplier
        : 10 * SizeConfig.heightMultiplier,
    decoration: BoxDecoration(
        color: isActive ? Color(0xFF185a9d) : Colors.black26,
        borderRadius: BorderRadius.circular(2 * SizeConfig.heightMultiplier)),
  );
}

class _ProductDisplayState extends State<ProductDisplay> {
  final String back;
  _ProductDisplayState({Key key, @required this.back});
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    SubCatergoryNotifier subcatergoryNotifier =
        Provider.of<SubCatergoryNotifier>(context, listen: false);
    getSubCatergories(subcatergoryNotifier);
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context, listen: false);
    getCatergories(catergoryNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    SubCatergoryNotifier subcatergoryNotifier =
        Provider.of<SubCatergoryNotifier>(context);
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context);

    _onProductDeleted(Product product) {
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return Productlist();
        },
      ));

      productNotifier.deleteProduct(product);
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(45.0),
                                bottomRight: Radius.circular(45.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    productNotifier.currentProduct.images),
                                fit: BoxFit.fill)),
                      )),
                  (back == 'offer')
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Store();
                            }));
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: catergoryNotifier.catergoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return (productNotifier.currentProduct.catergory ==
                                    catergoryNotifier
                                        .catergoryList[index].catergory)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: subcatergoryNotifier
                                        .subcatergoryList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (productNotifier.currentProduct
                                                  .subcatergory ==
                                              subcatergoryNotifier
                                                  .subcatergoryList[index]
                                                  .subcatergory)
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: IconButton(
                                                onPressed: () {
                                                  subcatergoryNotifier
                                                          .currentSubCatergory =
                                                      subcatergoryNotifier
                                                              .subcatergoryList[
                                                          index];
                                                  catergoryNotifier
                                                          .currentCatergory =
                                                      catergoryNotifier
                                                          .catergoryList[index];
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                    return Productlist();
                                                  }));
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back_ios,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Container();
                                    })
                                : Container();
                          }),
                ],
              ),
              Column(
                // shrinkWrap: false,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 9 * SizeConfig.heightMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),
                  Container(
                    height: 400,
                    child: PageView(
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentpage = page;
                          });
                        },
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 25.0),
                                child: Text(
                                  productNotifier.currentProduct.productname,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 8.0),
                                child: Text(
                                  'By ${productNotifier.currentProduct.catergory}',
                                  style: Theme.of(context).textTheme.display1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 35.0),
                                child: (productNotifier
                                            .currentProduct.offerprice ==
                                        0)
                                    ? Row(
                                        children: <Widget>[
                                          Text('Product Price :',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(fontSize: 19.0)),
                                          Text(
                                              'Rs. ${productNotifier.currentProduct.price.toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(fontSize: 19.0)),
                                        ],
                                      )
                                    : Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text('New Price : ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1),
                                              Text(
                                                'Rs.${productNotifier.currentProduct.offerprice.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                        color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            children: <Widget>[
                                              Text('Old Price : ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1),
                                              Text(
                                                  'Rs.${productNotifier.currentProduct.price.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough)),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("In Stock :  ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1),
                                    Text(
                                        productNotifier.currentProduct.quntity
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(color: Colors.red)),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.blueGrey,
                                thickness: .3,
                              ),
                            ],
                          ),

                          // second page
                          ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 25.0,
                                    bottom: 15.0),
                                child: Text('Product description',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(fontSize: 20.0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, bottom: 150.0),
                                child: Text(
                                  '\t ${productNotifier.currentProduct.description}',
                                  style: Theme.of(context).textTheme.display1,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: FloatingActionButton(
                heroTag: 'b1',
                backgroundColor: Color(0xFF185a9d),
                onPressed: () {
                  UserAccessProductEdit().authorizedAccess(context);
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: 'b2',
              backgroundColor: Colors.red,
              onPressed: () {
                FirebaseAuth.instance.currentUser().then((user) {
                  Firestore.instance
                      .collection("/Staff")
                      .where('uid', isEqualTo: user.uid)
                      .getDocuments()
                      .then((docs) {
                    if (docs.documents[0].exists) {
                      if (docs.documents[0].data['role'] == 'admin') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  height: 300.0,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.warning,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          "After you delete an Product, it's permanently deleted. Product can't be undeleted.",
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .copyWith(
                                                color: Colors.red,
                                              ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(30.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          elevation: 4.0,
                                          child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              onTap: () {
                                                deleteProduct(
                                                    productNotifier
                                                        .currentProduct,
                                                    _onProductDeleted);
                                              },
                                              child: buttonContainer(
                                                  context, 'okey', 40, 150)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
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
                                          "Only admin can delete",
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(30.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          elevation: 4.0,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: buttonContainer(
                                                context, 'Okey', 40, 100),
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
            ),
          ],
        ),
      ),
    );
  }
}
