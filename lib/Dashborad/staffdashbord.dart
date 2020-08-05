

import 'package:flutter/material.dart';
import 'package:admin/profile/proflie.dart';

import 'package:admin/module/staff.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/database/staffdatabase.dart';
import 'package:provider/provider.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:admin/mainpages/home.dart';

import 'package:admin/mainpages/vieworder.dart' as firstpage;
import 'package:admin/product/productcollection.dart' as secondpage;
class StaffPanel extends StatefulWidget {
  @override
  _StaffPanelState createState() => _StaffPanelState();
}

class _StaffPanelState extends State<StaffPanel>with SingleTickerProviderStateMixin {
  TabController contraller;
  @override
  void initState(){
    super.initState();
    contraller=new  TabController(length: 2, vsync: this);
  }
  @override
  void dispose(){
    contraller.dispose();
    super.dispose();
  }
  final DatabaseService databaseService = DatabaseService();
  final AuthService _auth=AuthService();

  GlobalKey <ScaffoldState>_key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    final staff = Provider.of<Staff>(context, listen: false);
    return SafeArea(
      child: StreamBuilder<Staff>(
          stream: DatabaseService(uid: staff.staffkey).profileData,
          builder: (context, snapshot) {
            if (!snapshot.hasData){
              return Loading();
            }
            final profile = snapshot.data;
            return Scaffold(
              key: _key,
              drawer: Drawer(

                // linear background
                child: Container(
                  color: Color(0xFFE3F2FD),
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(

                        accountEmail: Text(profile.email),
                        currentAccountPicture: GestureDetector(
                          child: CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Icon(Icons.person,color: Colors.blueGrey,size: 50,)
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                            tileMode: TileMode.repeated,
                          ),
                        ),
                      ),// homepage


                      //my account

                      InkWell(
                        onTap: (){
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Myaccount()),);
                        },
                        child: ListTile(
                          title: Text("My Account",style: Theme.of(context).textTheme.display1),
                          leading: Icon(Icons.person,color:Colors.blueGrey ,size: 25),
                        ),
                      ),

                      Divider(color: Colors.blueGrey,),

                      //setting

                      InkWell(
                        child: ListTile(
                          title: Text("Settings",style: Theme.of(context).textTheme.display1),
                          leading: Icon(Icons.settings,color:Colors.blueGrey,size: 25),
                        ),
                      ),

                      Divider(color: Colors.blueGrey),


                      //logout
                      InkWell(
                        onTap: ()async{
                          await _auth.signOut(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Homepage()));
                        },
                        child: ListTile(
                          title: Text("Logout",style: Theme.of(context).textTheme.display1),
                          leading: Icon(Icons.arrow_back,color: Colors.blueGrey,size: 25),
                        ),
                      ),
                    ],
                  ),),),
              appBar: _customAppBar(_key,context),
              bottomNavigationBar: Material(
                color: Colors.teal,
                child: TabBar(
                  controller: contraller,
                  tabs: <Widget>[
                    new Tab(icon: new Icon(Icons.shopping_basket),) ,
                    new Tab(icon: new Icon(Icons.add),) ,
                  ],

                ),
              ),
              body: TabBarView(
                controller: contraller,
                children: <Widget>[
                  new firstpage.ViewOrder(),
                  new secondpage.ProductCollection()
                ],
              ),

            );
          }
      ),
    );
  }
}



Widget  _customAppBar(GlobalKey<ScaffoldState> globalKey,BuildContext context){
  return PreferredSize(
    preferredSize: Size.fromHeight(12*SizeConfig.heightMultiplier),
    child: Material(
      elevation: 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
        ),
        child: Padding(
          padding:  EdgeInsets.only(left:2.2*SizeConfig.widthMultiplier,right:5*SizeConfig.widthMultiplier ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.list,color: Colors.white,size: 5*SizeConfig.heightMultiplier,),
                  onPressed: (){
                    globalKey.currentState.openDrawer();

                  },),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 7.0,
                  child: InkWell(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Storehome()));
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color:Color(0xFF185a9d),
                              style: BorderStyle.solid,
                              width: 2.0
                          )
                      ),
                      child: Center(
                        child: Text("Go to Store",
                            style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d) )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),),
    ),
  );
}



