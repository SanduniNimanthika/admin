
import 'package:flutter/material.dart';

import 'package:admin/notifer/perscriptionnotifer.dart';

import 'package:admin/database/perscription.dart';

import 'package:provider/provider.dart';
import 'package:admin/commanpages/commanWidgets.dart';
class PerscriptionHistory extends StatefulWidget {
  final String useremail;

  PerscriptionHistory({Key key, @required this.useremail}) : super(key: key);
  @override
  _PerscriptionHistoryState createState() => _PerscriptionHistoryState(useremail: useremail);
}

class _PerscriptionHistoryState extends State<PerscriptionHistory> {
  final String useremail;

  _PerscriptionHistoryState({Key key, @required this.useremail});
  @override
  void initState() {
    super.initState();

    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier =
        Provider.of<PerscriptionOrderHistoryNotifier>(context, listen: false);
    getPerscriptionOrderHistorys(perscriptionOrderHistoryNotifier,useremail);
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
                  return InkWell(
                    onTap: (){
                      perscriptionOrderHistoryNotifier.currentPerscriptionOrderHistory =
                      perscriptionOrderHistoryNotifier
                          .perscriptionOrderHistoryList[index];
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DisplayDetails();
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
                                                        ),
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


class DisplayDetails extends StatefulWidget {
  @override
  _DisplayDetailsState createState() => _DisplayDetailsState();
}

class _DisplayDetailsState extends State<DisplayDetails> {
  @override
  Widget build(BuildContext context) {
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier =
    Provider.of<PerscriptionOrderHistoryNotifier>(context);
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
                                    image: NetworkImage(perscriptionOrderHistoryNotifier
                                        .currentPerscriptionOrderHistory.images),
                                    fit: BoxFit.fill)),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 25.0,bottom: 10 ,right: 15),
                        child: Column(
                          children: <Widget>[
                            Text('Special Description :',
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                  // fontSize: 19.0,
                                    color: Color(0xFF185a9d))),
                            Text(
                                perscriptionOrderHistoryNotifier
                                    .currentPerscriptionOrderHistory.specialDescription,
                                style: Theme.of(context).textTheme.display1,
                                textAlign: TextAlign.justify,
                              //.copyWith(fontSize: 29),
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
                                child: Text('Required Days:',
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
                              child:  Text(
                                  perscriptionOrderHistoryNotifier
                                      .currentPerscriptionOrderHistory.days.toString(),
                                  style: Theme.of(context).textTheme.display1
                                //.copyWith(fontSize: 29),
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
                                child: Text('Ordered date:',
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
                                  perscriptionOrderHistoryNotifier.currentPerscriptionOrderHistory.date,
                                  style: Theme.of(context).textTheme.display1
                                //  .copyWith(fontSize: 19.0)
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ))));
  }
}
