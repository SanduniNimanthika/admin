import 'package:admin/module/oderhistory.dart';
import 'package:admin/order/odertab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:admin/notifer/oderhistorynotifer.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/database/oderhistory.dart';
import 'package:provider/provider.dart';
import 'package:admin/commanpages/configue.dart';

class ProductOrder extends StatefulWidget {
  @override
  _ProductOrderState createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {
  @override
  void initState() {
    super.initState();

    ProductOrderHistoryNotifier productOrderHistoryNotifier =
        Provider.of<ProductOrderHistoryNotifier>(context, listen: false);
    getProductOrderHistory(productOrderHistoryNotifier);
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ProductOrderHistoryNotifier productOrderHistoryNotifier =
        Provider.of<ProductOrderHistoryNotifier>(context);
    Future<void> _refreshList() async {
      getProductOrderHistory(productOrderHistoryNotifier);
    }

    return SafeArea(
        child: Scaffold(
      key: _key,
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount:
                productOrderHistoryNotifier.productOrderHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  productOrderHistoryNotifier.currentProductOrderHistory =
                      productOrderHistoryNotifier
                          .productOrderHistoryList[index];
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Edit();
                      });
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
                          height: MediaQuery.of(context).size.height / 9 * 2,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25.0),
                                              bottomRight:
                                                  Radius.circular(25.0))),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                bottomRight:
                                                    Radius.circular(25.0)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    productOrderHistoryNotifier
                                                        .productOrderHistoryList[
                                                            index]
                                                        .images),
                                                fit: BoxFit.fill)),
                                      )),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            productOrderHistoryNotifier
                                                .productOrderHistoryList[index]
                                                .productname,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead
                                                .copyWith(
                                                    color: Color(0xFF185a9d),
                                                    fontSize: 20.0),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Qty - .${productOrderHistoryNotifier.productOrderHistoryList[index].quntity.toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            productOrderHistoryNotifier
                                                .productOrderHistoryList[index]
                                                .status,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1
                                                .copyWith(color: Colors.green),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )),
              );
              //  : Container();
            }),
      ),
    ));
  }
}

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  ProductOrderHistory _currentProductOrderHistory;
  @override
  void initState() {
    super.initState();

    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);
    ProductOrderHistoryNotifier productOrderHistoryNotifier =
        Provider.of<ProductOrderHistoryNotifier>(context, listen: false);
    if (productOrderHistoryNotifier.currentProductOrderHistory != null) {
      _currentProductOrderHistory =
          productOrderHistoryNotifier.currentProductOrderHistory;
    } else {
      _currentProductOrderHistory = ProductOrderHistory();
    }
  }

  _onOrderHistoryUploaded(ProductOrderHistory productOrderHistory) {
    ProductOrderHistoryNotifier productOrderHistoryNotifier =
        Provider.of<ProductOrderHistoryNotifier>(context, listen: false);
    productOrderHistoryNotifier.addProductOrderHistory(productOrderHistory);
  }

  @override
  Widget build(BuildContext context) {
    ProductOrderHistoryNotifier productOrderHistoryNotifier =
        Provider.of<ProductOrderHistoryNotifier>(context);
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SingleChildScrollView(
                child: Container(
              color: Color(0xFFE3F2FD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3 * 1,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(45.0),
                                bottomRight: Radius.circular(45.0)),
                            image: DecorationImage(
                                image: NetworkImage(productOrderHistoryNotifier
                                    .currentProductOrderHistory.images),
                                fit: BoxFit.fill)),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 25.0),
                    child: Text(
                        productOrderHistoryNotifier
                            .currentProductOrderHistory.productname,
                        style: Theme.of(context).textTheme.subtitle
                        //.copyWith(fontSize: 29),
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Text('In Stock :',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        // fontSize: 19.0,
                                        color: Colors.red)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: ListView.builder(
                                itemCount: productNotifier.productList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return (productNotifier
                                              .productList[index].productkey ==
                                          productOrderHistoryNotifier
                                              .currentProductOrderHistory
                                              .productkey)
                                      ? Text(
                                          productNotifier
                                              .productList[index].quntity
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1)
                                      : Container();
                                })),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Text('Required Qty:',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        // fontSize: 19.0,
                                        color: Color(0xFF185a9d))),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              productOrderHistoryNotifier
                                  .currentProductOrderHistory.quntity
                                  .toString(),
                              style: Theme.of(context).textTheme.display1
                              //  .copyWith(fontSize: 19.0)
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 35.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Text('Total Price:',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        // fontSize: 19.0,
                                        color: Color(0xFF185a9d))),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              'Rs. ${productOrderHistoryNotifier.currentProductOrderHistory.fullprice}',
                              style: Theme.of(context).textTheme.display1
                              //  .copyWith(fontSize: 19.0)
                              ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey,
                    thickness: .3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 15.0, bottom: 15.0),
                    child: Text("User Details",
                        style: Theme.of(context).textTheme.subtitle
                        //.copyWith(fontSize: 29),
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Text('Address:',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        // fontSize: 19.0,
                                        color: Color(0xFF185a9d))),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  productOrderHistoryNotifier
                                      .currentProductOrderHistory.fullname,
                                  style: Theme.of(context).textTheme.display1),
                              Text(
                                  productOrderHistoryNotifier
                                      .currentProductOrderHistory.address,
                                  style: Theme.of(context).textTheme.display1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 15.0,
                            ),
                            child: Text('Telephone No:',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                        // fontSize: 19.0,
                                        color: Color(0xFF185a9d))),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              productOrderHistoryNotifier
                                  .currentProductOrderHistory.telenumber,
                              style: Theme.of(context).textTheme.display1
                              //  .copyWith(fontSize: 19.0)
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0),
                      child: InkWell(
                        child: Text("more...",
                            style:
                                Theme.of(context).textTheme.display1.copyWith(
                                    // fontSize: 19.0,
                                    color: Color(0xFF185a9d))),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, top: 5),
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            2 * SizeConfig.heightMultiplier),
                        elevation: 7.0,
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              _currentProductOrderHistory.status = 'accepted';
                            });


                            Firestore.instance.collection('Product').where(
                                "uid",
                                isEqualTo: productOrderHistoryNotifier
                                    .currentProductOrderHistory.productkey)
                                .getDocuments()
                                .then((querySnapshot) {
                              querySnapshot.documents
                                  .forEach((result) {

                                  String id = result.data['uid'];
                                 print (id);
                                 Firestore.instance.collection('Product').document(id).updateData({
                             'quntity':result.data['quntity']-
                                  productOrderHistoryNotifier
                                      .currentProductOrderHistory.quntity
                            });
                                // new documents would be created in other collection

                                print(result.data.entries.elementAt(4).value);
                                print(result.data['uid']);
                              });
                            });

                            uploadOrderHistory(
                                _currentProductOrderHistory /*widget.isUpdating*/,
                                _onOrderHistoryUploaded);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OrderTab()), (route)=>false);
                          },
                          child: Container(
                            height: 6.7 * SizeConfig.heightMultiplier,
                            width: 29 * SizeConfig.heightMultiplier,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF185a9d),
                                  const Color(0xFF43cea2)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  2 * SizeConfig.heightMultiplier),
                            ),
                            child: Center(
                              child: Text("Accept",
                                  style: Theme.of(context).textTheme.subhead),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))));
  }
}