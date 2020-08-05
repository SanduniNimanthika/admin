import 'dart:ui';

import 'package:admin/StoreDisplay/subcatergorylist.dart';
import 'package:admin/StoreDisplay/substore.dart';
import 'package:admin/database/Catdatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/catergory.dart';
import 'package:admin/module/subcar.dart';
import 'package:admin/database/subcatdatabse.dart';

class StoreHomes extends StatefulWidget {
  @override
  _StoreHomesState createState() => _StoreHomesState();
}

class _StoreHomesState extends State<StoreHomes> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final catergories = Provider.of<List<Catergory>>(context);
    final subcatergories = Provider.of<List<SubCatergory>>(context);
    return Scaffold(
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
            child: (catergories == null || catergories.isEmpty)
                ? Text('No Catergories')
                : Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 8,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: catergories.length,
                            itemBuilder: (context, index) {
                              final catergory = catergories[index];
                              return ExpansionTile(
                                title: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SubStore()));
                                    },
                                    child: Text(catergory.catergory,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead),
                                  ),
                                ),
                                children: <Widget>[
                                  (  (subcatergories == null ||
                                          subcatergories.isEmpty))
                                      ? Text('No SubCatergories')
                                      : Column(
                                          children: <Widget>[
                                            ListView.builder(
                                                itemCount:
                                                    subcatergories.length,
                                                shrinkWrap: true,
                                                physics: ClampingScrollPhysics(),
                                                itemBuilder:
                                                    (context, index) {
                                                  final subcatergory =
                                                      subcatergories[index];

                                                  return (catergory.catergory==subcatergory.catergory)
                                                      ?
                                                    Column(
                                                    children: <Widget>[
                                                      Divider(),
                                                      ListTile(
                                                        title: Text(
                                                            subcatergory
                                                                .subcatergory),
                                                      ),
                                                    ],
                                                  ):null;
                                                })
                                          ],
                                        )
                                ],


                              );
                            }),
                      ),
                    ],
                  )),
      ),
      body: Column(
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
                    top: 3 * SizeConfig.heightMultiplier,
                    left: 2 * SizeConfig.heightMultiplier,
                    right: 2 * SizeConfig.heightMultiplier),
                child: Row(
                  children: <Widget>[
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
                      "Product Categories",
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
    );
  }
}
