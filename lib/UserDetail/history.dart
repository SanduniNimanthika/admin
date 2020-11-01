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

class History extends StatefulWidget {
 final String useruid;

 History({Key key, @required this.useruid}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState(useruid: useruid);
}

class _HistoryState extends State<History> {
  final String useruid;

  _HistoryState({Key key, @required this.useruid});
  @override
  void initState() {
    super.initState();

    ProductOrderHistoryNotifier productOrderHistoryNotifier =
        Provider.of<ProductOrderHistoryNotifier>(context, listen: false);
    getProductOrderHistorys(productOrderHistoryNotifier,useruid);
  }

  String selectedtye;
  int x;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> _accounttye = <String>['5', '10', '15', '20', 'all'];


  @override
  Widget build(BuildContext context) {
    ProductOrderHistoryNotifier productOrderHistoryNotifier =
        Provider.of<ProductOrderHistoryNotifier>(context);

    return SafeArea(
        child: Scaffold(
      key: _key,
      body: SingleChildScrollView(

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
                productOrderHistoryNotifier.productOrderHistoryList.length:
                (productOrderHistoryNotifier.productOrderHistoryList.length<x)
                    ?productOrderHistoryNotifier.productOrderHistoryList.length:x,


                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                                                bottomRight: Radius.circular(25.0))),
                                        width: MediaQuery.of(context).size.width / 3,
                                        height:
                                            MediaQuery.of(context).size.height / 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25.0),
                                                  bottomRight: Radius.circular(25.0)),
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
                                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                              'Rs.${productOrderHistoryNotifier.productOrderHistoryList[index].price.toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
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
                      ));
                  //  : Container();
                }),
          ],
        ),
      ),
    ));
  }
}
