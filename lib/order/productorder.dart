import 'package:admin/UserDetail/userDetail.dart';
import 'package:admin/commanpages/commanWidgets.dart';
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
import 'package:admin/services/usermanagment.dart';


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
  String selectedtye;
  int x;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> _accounttye = <String>['5', '10', '15', '20', 'all'];

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
      body: SingleChildScrollView(

        child: RefreshIndicator(
          onRefresh: _refreshList,
          child: Column(

            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Row(
                  children: <Widget>[
                    Text("show",
                        style: Theme.of(context).textTheme.display1.copyWith(
                          color: Color(0xFF185a9d),
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    DropdownButton(
                      items: _accounttye
                          .map((value) => DropdownMenuItem(
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        value: value,
                      ))
                          .toList(),
                      onChanged: (selectedlist) {
                        setState(() {
                          selectedtye = selectedlist;
                          if(selectedtye=='all'){
                            x=5000000000000000000;
                          }else{
                            x=int.parse(selectedtye);
                            print(selectedtye);
                            print(selectedlist);
                            print(x);}


                        });
                      },
                      value: selectedtye,
                      isExpanded: false,
                    ),

                  ],
                ),

              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:(selectedtye==null)?
                  productOrderHistoryNotifier
                      .productOrderHistoryList.length:
                  (productOrderHistoryNotifier.productOrderHistoryList.length<x)
                      ?productOrderHistoryNotifier.productOrderHistoryList.length:x,
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
                                decoration:boxDecarationhistory(),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            decoration: boxDecarationhistory(),
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
                                                          ),
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
            ],
          ),
        ),
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
                        left: 15.0, right: 15.0, top: 7.0, bottom: 15.0),
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
                              right: 5.0,
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
                        .copyWith(fontSize: 19),
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
                                  '${productOrderHistoryNotifier
                                      .currentProductOrderHistory.fullname},',
                                  style: Theme.of(context).textTheme.display1),
                              Text(
                                  '${productOrderHistoryNotifier
                                      .currentProductOrderHistory.address},',
                                  style: Theme.of(context).textTheme.display1),
                              Text(
                                  productOrderHistoryNotifier
                                      .currentProductOrderHistory.hometown,
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
                              right: 5.0,
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
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetail(useruid: productOrderHistoryNotifier
                              .currentProductOrderHistory.userkey,back:'order')));
                        },
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
                            20),
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
                            UserManagment().authorizedAccess(context);

                          },
                          child: buttonContainer(context, 'Accept', 43, 200)

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))));
  }
}
