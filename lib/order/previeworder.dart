import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/module/perscriptionOrder.dart';

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
                    fit: BoxFit.fill,
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
                    child:listBar(context,perscriptionOrderHistoryNotifier
                        .currentPerscriptionOrderHistory.fullname, Icons.account_circle)

                  ),
                  Divider(),
                  (perscriptionOrderHistoryNotifier
                              .currentPerscriptionOrderHistory
                              .firstlineaddress !=
                          null)
                      ?listBar(context, perscriptionOrderHistoryNotifier
                      .currentPerscriptionOrderHistory
                      .firstlineaddress,Icons.home)

                      : Container(),
                  Divider(),
                  listBar(context, perscriptionOrderHistoryNotifier
                      .currentPerscriptionOrderHistory.hometown,Icons.location_on),

                  Divider(),
                  listBar(context, perscriptionOrderHistoryNotifier
                      .currentPerscriptionOrderHistory.telenumber,Icons.phone)
                  ,

                  Divider(),
                  listBar(context,   perscriptionOrderHistoryNotifier
                      .currentPerscriptionOrderHistory.email,Icons.email),

                  Divider(),
                  listBar(context, perscriptionOrderHistoryNotifier
                      .currentPerscriptionOrderHistory.days
                      .toString(), Icons.calendar_today),


                  Divider(),
                  (perscriptionOrderHistoryNotifier
                              .currentPerscriptionOrderHistory
                              .specialDescription !=
                          null)

                      ? listBar(context, perscriptionOrderHistoryNotifier
                      .currentPerscriptionOrderHistory
                      .specialDescription, Icons.edit)

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
                          {
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
                          }

                        },
                        child: buttonContainer(context,'Accpeted & Send a email', 43, null)

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
