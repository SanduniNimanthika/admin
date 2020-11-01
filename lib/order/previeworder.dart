import 'package:admin/module/perscriptionOrder.dart';
import 'package:admin/order/message.dart';
import 'package:admin/order/odertab.dart';
import 'package:admin/order/sms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/notifer/perscriptionnotifer.dart';
import 'package:admin/database/perscription.dart';
import 'package:admin/commanpages/configue.dart';

class PerscriptionPreview extends StatefulWidget {
  @override
  _PerscriptionPreviewState createState() => _PerscriptionPreviewState();
}

class _PerscriptionPreviewState extends State<PerscriptionPreview> {
  ProductPerscription _currentPerscriptionOrderHistory;
  void initState() {
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier =
        Provider.of<PerscriptionOrderHistoryNotifier>(context, listen: false);
    getPerscriptionOrderHistory(perscriptionOrderHistoryNotifier);
    super.initState();
    if (perscriptionOrderHistoryNotifier.currentPerscriptionOrderHistory != null) {
      _currentPerscriptionOrderHistory =
          perscriptionOrderHistoryNotifier.currentPerscriptionOrderHistory;
    } else {
      _currentPerscriptionOrderHistory = ProductPerscription();
    }
  }

  _onOrderHistoryUploaded(ProductPerscription productPerscription) {
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier =
    Provider.of<PerscriptionOrderHistoryNotifier>(context, listen: false);
    perscriptionOrderHistoryNotifier.addProductPerscriptionHistory(productPerscription);
  }

  @override
  Widget build(BuildContext context) {
    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier =
        Provider.of<PerscriptionOrderHistoryNotifier>(context);
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height / 5 * 3,
                  floating: false,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF185a9d),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OrderTab()));
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                    perscriptionOrderHistoryNotifier
                        .currentPerscriptionOrderHistory.images,
                    fit: BoxFit.cover,
                  )),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        perscriptionOrderHistoryNotifier
                            .currentPerscriptionOrderHistory.fullname,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  Divider(),
                  (perscriptionOrderHistoryNotifier
                              .currentPerscriptionOrderHistory
                              .firstlineaddress !=
                          null)
                      ? ListTile(
                          leading: Icon(Icons.home),
                          title: Text(
                            perscriptionOrderHistoryNotifier
                                .currentPerscriptionOrderHistory
                                .firstlineaddress,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        )
                      : Container(),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      perscriptionOrderHistoryNotifier
                          .currentPerscriptionOrderHistory.hometown,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      perscriptionOrderHistoryNotifier
                          .currentPerscriptionOrderHistory.telenumber,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Divider(),
                  ListTile(
                      leading: Icon(Icons.email),
                      title: (perscriptionOrderHistoryNotifier
                                  .currentPerscriptionOrderHistory.email !=
                              null)
                          ? Text(
                              perscriptionOrderHistoryNotifier
                                  .currentPerscriptionOrderHistory.email,
                              style: Theme.of(context).textTheme.display1,
                            )
                          : Text(
                              "Not provide",
                              style: Theme.of(context).textTheme.display1,
                            )),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: (perscriptionOrderHistoryNotifier
                                .currentPerscriptionOrderHistory.days
                                .toString() !=
                            null)
                        ? Text(
                            perscriptionOrderHistoryNotifier
                                .currentPerscriptionOrderHistory.days
                                .toString(),
                            style: Theme.of(context).textTheme.display1,
                          )
                        : Text(
                            "Not provide",
                            style: Theme.of(context).textTheme.display1,
                          ),
                  ),
                  Divider(),
                  (perscriptionOrderHistoryNotifier
                              .currentPerscriptionOrderHistory
                              .specialDescription !=
                          null)
                      ? ListTile(
                          leading: Icon(Icons.edit),
                          title: Text(
                            perscriptionOrderHistoryNotifier
                                .currentPerscriptionOrderHistory
                                .specialDescription,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        )
                      : Container(),
                  // button
                  Padding(
                    padding: EdgeInsets.only(
                        top: 34, bottom: 20, left: 15, right: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(
                          5 * SizeConfig.heightMultiplier),
                      elevation: 4.0,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    height: 170.0,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Text(
                                            "Send email or message",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 30.0,
                                                bottom: 30.0,
                                                left: 50.0,
                                                right: 50.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _currentPerscriptionOrderHistory.status = 'accepted';
                                                    });
                                                    uploadPerscriptionHistory(
                                                        _currentPerscriptionOrderHistory /*widget.isUpdating*/,
                                                        _onOrderHistoryUploaded);

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EmailSender(
                                                                    text: perscriptionOrderHistoryNotifier
                                                                        .currentPerscriptionOrderHistory
                                                                        .email)));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://www.lawforgood.org.uk/wp-content/uploads/2017/09/Email-Icon.png"),
                                                          fit: BoxFit.fill),
                                                    ),
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                  //  Navigator.push(
                                                  //      context,
                                                  //      MaterialPageRoute(
                                                    //       builder: (context) =>
                                                      //         Messaage()));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/IMessage_logo.svg/768px-IMessage_logo.svg.png"),
                                                          fit: BoxFit.fill),
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 40,
                          width: 15 * SizeConfig.heightMultiplier,
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
                                5 * SizeConfig.heightMultiplier),
                          ),
                          child: Center(
                            child: Text("Submit",
                                style: Theme.of(context).textTheme.subhead),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
