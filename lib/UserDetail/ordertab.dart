import 'package:admin/UserDetail/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:admin/UserDetail/history.dart' as firstpage;
import 'package:admin/UserDetail/perscriptionhistory.dart' as secondpage;
import 'package:admin/commanpages/commanWidgets.dart';

class Tabcontroller extends StatefulWidget {
  final int selectedPage;
  final String useremail;
  final String useruid;
  Tabcontroller(
      {Key key,
      @required this.selectedPage,
      @required this.useremail,
      @required this.useruid})
      : super(key: key);
  @override
  _TabcontrollerState createState() => _TabcontrollerState(
      selectedPage: selectedPage, useruid: useruid, useremail: useremail);
}

class _TabcontrollerState extends State<Tabcontroller>
    with SingleTickerProviderStateMixin {
  final int selectedPage;

  final String useremail;
  final String useruid;
  _TabcontrollerState(
      {Key key,
      @required this.selectedPage,
      @required this.useremail,
      @required this.useruid});
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: selectedPage,
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: linearcolor()
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetail(useruid: useruid,back: "userdetail",)));

                      },
                    ),
                  ),
                  TabBar(
                    indicatorColor: Colors.amber,
                    labelColor: Colors.white,
                    controller: controller,
                    tabs: <Widget>[
                      tab("https://icons-for-free.com/iconfiles/png/512/buy+cart+online+shopping+shop+shopping+shopping+basket+icon-1320191078019322255.png"),
                    tab('https://image.flaticon.com/icons/png/512/1560/1560913.png'),

                    ],
                  ),
                ],
              ),
            ),
          ),
          body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new firstpage.History(
                useruid: useruid,
              ),
              new secondpage.PerscriptionHistory(
                useremail: useremail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget tab(String name){
  return Tab(
    icon: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Image(
          image: NetworkImage(
            name
          ),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}