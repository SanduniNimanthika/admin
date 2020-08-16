import 'dart:ui';
import 'package:admin/database/Catdatabase.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:admin/StoreDisplay/catergorynotifer.dart';
import 'package:admin/StoreDisplay/subcatergorylist.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context, listen: false);
    getCatergories(catergoryNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context);

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          // linear background
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(23.0),
                      child: Text(
                        "Product catergories",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white),
                      ),
                    )),
                  ),
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: catergoryNotifier.catergoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueGrey,
                                thickness: 1,
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      catergoryNotifier.currentCatergory =
                                          catergoryNotifier
                                              .catergoryList[index];
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return SubCatergorylist();
                                      }));
                                    },
                                    child: Text(
                                        catergoryNotifier
                                            .catergoryList[index].catergory,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ],
              )),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/dashbord/epharmacy.jpg"),
                            fit: BoxFit.fill)),
                    height: (MediaQuery.of(context).size.height / 3) * 1,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      // make sure we apply clip it properly
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Opacity(
                          opacity: .5,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF185a9d),
                                  const Color(0xFF43cea2)
                                ],
                                tileMode: TileMode.repeated,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 3.5 * SizeConfig.heightMultiplier,
                        left: 2 * SizeConfig.heightMultiplier,
                        right: 2 * SizeConfig.heightMultiplier),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                UserManagment().authorizedAccess(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 25.0,
                                color: Color(0xFF185a9d),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(
                              Icons.list,
                              size: 5 * SizeConfig.heightMultiplier,
                              color: Color(0xFF185a9d),
                            ),
                            onPressed: () {
                              _key.currentState.openDrawer();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "Medicare",
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(fontSize: 30),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      size: 5 * SizeConfig.heightMultiplier,
                                      color: Color(0xFF185a9d),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5 * SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Text(
                          "Offers",
                          style: Theme.of(context).textTheme.subtitle,
                        )),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(
                          Icons.list,
                          size: 5 * SizeConfig.heightMultiplier,
                          color: Color(0xFF185a9d),
                        ),
                        onPressed: () {
                          _key.currentState.openDrawer();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
