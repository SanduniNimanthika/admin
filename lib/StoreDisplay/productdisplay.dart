import 'package:admin/StoreDisplay/productlist.dart';
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

class ProductDisplay extends StatefulWidget {
  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    super.initState();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

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
        appBar: _customAppBar(
            _key, context, productNotifier.currentProduct.subcatergory),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 25.0),
                child: Text(
                  productNotifier.currentProduct.productname,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
                child: Text(
                  'By ${productNotifier.currentProduct.catergory}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 35.0),
                child: (productNotifier.currentProduct.offerprice == 0)
                    ? Text(
                        'Rs. ${productNotifier.currentProduct.price.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 19.0))
                    : Row(
                        children: <Widget>[
                          Text(
                            'Rs.${productNotifier.currentProduct.offerprice.toString()}',
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(color: Colors.red),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 28.0),
                            child: Text(
                                'Rs.${productNotifier.currentProduct.price.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        decoration:
                                            TextDecoration.lineThrough)),
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Text("In Stock :  ",
                        style: Theme.of(context).textTheme.display1),
                    Text(productNotifier.currentProduct.quntity.toString(),
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
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
                        deleteProduct(
                            productNotifier.currentProduct, _onProductDeleted);
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
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Center(
                                                child: Text("okay",
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

Widget _customAppBar(
    GlobalKey<ScaffoldState> globalKey, BuildContext context, String subname) {
  SubCatergoryNotifier subcatergoryNotifier =
      Provider.of<SubCatergoryNotifier>(context);
  return PreferredSize(
    preferredSize: Size.fromHeight(10 * SizeConfig.heightMultiplier),
    child: Material(
      elevation: 0.0,
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
          ),
        ),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: subcatergoryNotifier.subcatergoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return (subname ==
                      subcatergoryNotifier.subcatergoryList[index].subcatergory)
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          subcatergoryNotifier.currentSubCatergory =
                              subcatergoryNotifier.subcatergoryList[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
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
            }),
      ),
    ),
  );
}
