import 'package:admin/StoreDisplay/store.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/module/staff.dart';

import 'package:admin/commanpages/configue.dart';
import 'package:admin/database/staffdatabase.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:admin/notifer/perscriptionnotifer.dart';
import 'package:admin/notifer/oderhistorynotifer.dart';
import 'package:admin/database/productdatabase.dart';
import 'package:admin/database/perscription.dart';
import 'package:admin/database/oderhistory.dart';
import 'package:intl/intl.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:admin/order/odertab.dart';
import 'package:admin/notifer/productnotifer.dart';
import 'package:admin/profile/setting&privacy.dart';
class StaffPanel extends StatefulWidget {
  @override
  _StaffPanelState createState() => _StaffPanelState();
}
bool loading = false;

class _StaffPanelState extends State<StaffPanel> {

  final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    ProductNotifier productNotifier =
    Provider.of<ProductNotifier>(context, listen: false);
    getProducts(productNotifier);


    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier=
    Provider.of<PerscriptionOrderHistoryNotifier>(context, listen: false);
    getPerscriptionOrderHistory(perscriptionOrderHistoryNotifier);

    ProductOrderHistoryNotifier productOrderHistoryNotifier=
    Provider.of<ProductOrderHistoryNotifier>(context, listen: false);
    getProductOrderHistory(productOrderHistoryNotifier);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);


    PerscriptionOrderHistoryNotifier perscriptionOrderHistoryNotifier=
    Provider.of<PerscriptionOrderHistoryNotifier>(context);
    ProductOrderHistoryNotifier productOrderHistoryNotifier=
    Provider.of<ProductOrderHistoryNotifier>(context);

    final staff = Provider.of<Staff>(context, listen: false);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    return SafeArea(
      child: StreamBuilder<Staff>(
          stream: DatabaseService(uid: staff.staffkey).profileData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ));
            }
            final profile = snapshot.data;
            return loading
                ? Loading()
                :Scaffold(
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(gradient: linearcolor()),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15,
                            top:30,
                        right: 15),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Welcome ,",
                                  style: Theme.of(context).textTheme.headline,
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Setting()),
                                      );
                                    }),
                              ],
                            ),
                            Text(
                              profile.fullname,
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                  color: Colors.white, fontSize: 19),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              formatted,
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(top:130,left:20,
                            right: 20,bottom: 20),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OrderTab()));
                                },
                                child: dashbord(context,"Order","images/dashbord/drug_basket.png",(productOrderHistoryNotifier.productOrderHistoryList.length+perscriptionOrderHistoryNotifier.perscriptionOrderHistoryList.length).toString(),MediaQuery.of(context).size.width,)
                            ),

                            //product

                            Padding(
                              padding:  EdgeInsets.only(top:4*SizeConfig.heightMultiplier, ),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Store()));
                                  },
                                  child: dashbord(context,"Product","images/dashbord/drug_basket.png", productNotifier.productList.length.toString(),MediaQuery.of(context).size.width,)
                              ),
                            ),






                          ],
                        ),
                      )

                    ],

                    //  body:AdminPanel()
                  ),
                ));
          }),
    );
  }
}


Widget dashbord(BuildContext context,String name,String img,String count,double width){
  return  Material(
    shadowColor: Colors.teal,
    color: Color(0xFFE3F2FD),
    elevation: 10,
    type: MaterialType.canvas,
    borderRadius: BorderRadius.circular(27.0),
    child: Container(
      width: width,
      height:(SizeConfig.isMobilePortrait?(MediaQuery.of(context).size.height/7*2):(MediaQuery.of(context).size.height/2)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Text(name,style: Theme.of(context).textTheme.display1.copyWith(fontSize: 23,color: Color(0xFF185a9d)))),
            Expanded(
                flex: 6,
                child: Image(image:AssetImage(img),)),

            Expanded(
                flex:3,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(count,style: Theme.of(context).textTheme.display1.copyWith(fontSize: 23,color: Color(0xFF185a9d))),
            ))



          ],
        ),
      ),
    ),
  );
}




