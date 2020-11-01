import 'package:admin/order/previeworder.dart';
import 'package:flutter/material.dart';

import 'package:admin/notifer/perscriptionnotifer.dart';

import 'package:admin/database/perscription.dart';

import 'package:provider/provider.dart';

class PerscriptionHistory extends StatefulWidget {
  @override
  _PerscriptionHistoryState createState() => _PerscriptionHistoryState();
}

class _PerscriptionHistoryState extends State<PerscriptionHistory> {
  @override
  void initState() {
    super.initState();

    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier =
        Provider.of<PerscriptionOrderHistoryNotifier>(context, listen: false);
    getPerscriptionOrderHistory(perscriptionOrderHistoryNotifier);
  }

  String selectedtye;
  int x;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> _accounttye = <String>['5', '10', '15', '20', 'all'];

  @override
  Widget build(BuildContext context) {
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier =
        Provider.of<PerscriptionOrderHistoryNotifier>(context);

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
                perscriptionOrderHistoryNotifier
                        .perscriptionOrderHistoryList.length:
                (perscriptionOrderHistoryNotifier.perscriptionOrderHistoryList.length<x)
                    ?perscriptionOrderHistoryNotifier.perscriptionOrderHistoryList.length:x,


                itemBuilder: (BuildContext context, int index) {
                  print(perscriptionOrderHistoryNotifier.perscriptionOrderHistoryList[index].specialDescription);

                  return InkWell(
                    onTap: (){
                      perscriptionOrderHistoryNotifier.currentPerscriptionOrderHistory =
                      perscriptionOrderHistoryNotifier
                          .perscriptionOrderHistoryList[index];
                      Navigator.push(
                         context,
                         MaterialPageRoute(
                         builder: (context) => PerscriptionPreview()));
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
                                                        perscriptionOrderHistoryNotifier
                                                            .perscriptionOrderHistoryList[
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
                                                perscriptionOrderHistoryNotifier
                                                    .perscriptionOrderHistoryList[
                                                        index]
                                                    .date,
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
                                                child: (perscriptionOrderHistoryNotifier
                                                            .perscriptionOrderHistoryList[
                                                                index]
                                                            .status ==
                                                        'pending')
                                                    ? Text(
                                                        perscriptionOrderHistoryNotifier
                                                            .perscriptionOrderHistoryList[
                                                                index]
                                                            .status,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1
                                                            .copyWith(
                                                                color:
                                                                    Colors.green),
                                                      )
                                                    : Text(
                                                        perscriptionOrderHistoryNotifier
                                                            .perscriptionOrderHistoryList[
                                                                index]
                                                            .status,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .display1
                                                            .copyWith(
                                                                color: Colors.red),
                                                      ))
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
    ));
  }
}
