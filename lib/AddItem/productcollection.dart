import 'package:flutter/material.dart';
import 'package:admin/AddItem/product.dart' as firstpage;
import 'package:admin/StoreDisplay/store.dart'as secondpage;
class ProductCollection extends StatefulWidget {
  @override
  _ProductCollectionState createState() => _ProductCollectionState();
}

class _ProductCollectionState extends State<ProductCollection>with SingleTickerProviderStateMixin{
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
          bottomNavigationBar:Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF185a9d),
                  const Color(0xFF43cea2)
                ],
              ),
            ),
            child: TabBar(
              indicatorColor: Colors.amber,
              labelColor:Colors.white,
              controller: controller,
              tabs: <Widget>[
                new Tab(icon: new Icon(Icons.add,),),
                new Tab(icon: new Icon(Icons.visibility),),
              ],
            ),
          ) ,
          body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new firstpage.Item(),
              new secondpage.Store(),
            ],
          ),
        ),
      ),
    );
  }
}

