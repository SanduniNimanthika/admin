import 'package:admin/UserDetail/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:admin/UserDetail/history.dart' as firstpage;
import 'package:admin/UserDetail/perscriptionhistory.dart'as secondpage;
class OrderTab extends StatefulWidget {
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab>with SingleTickerProviderStateMixin{
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller=new TabController(length: 2, vsync: this);
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
        length: 2,
        child: Scaffold(
          appBar:AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return UserDetail();
                    }));
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: Text('Product Orders', style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),),
            backgroundColor: Color(0xFF185a9d),
            elevation: 0,
            bottom: TabBar(

              indicatorSize: TabBarIndicatorSize.tab,
              controller: controller,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF185a9d),
                    const Color(0xFF43cea2)
                  ],
                ),
                // borderRadius: BorderRadius.circular(40),
              ),
              tabs: <Widget>[
                new Tab(icon:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image(
                      image: NetworkImage(
                        'https://icons-for-free.com/iconfiles/png/512/buy+cart+online+shopping+shop+shopping+shopping+basket+icon-1320191078019322255.png',
                      ),
                      fit: BoxFit.cover,
                    ),

                  ),
                ),),
                new Tab(icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image(
                      image: NetworkImage(
                        'https://image.flaticon.com/icons/png/512/1560/1560913.png',
                      ),
                      fit: BoxFit.cover,
                    ),

                  ),
                ),),
              ],),
          ),

          body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new firstpage.History(),
              new secondpage.PerscriptionHistory(),
            ],
          ),
        ),
      ),
    );
  }
}

