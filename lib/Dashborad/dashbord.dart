import 'package:admin/services/usermanagment.dart';
import 'package:flutter/material.dart';
import 'package:admin/module/staff.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/database/staffdatabase.dart';
import 'package:provider/provider.dart';
class DashBord extends StatefulWidget {
  @override
  _DashBordState createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {

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
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10.0),
                  child:CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )
              );
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
                        accountName: Text(profile.fullname),
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


                      //home

                      InkWell(
                        onTap: (){
                          UserManagment().authorizedAccess(context);

                        },
                        child: ListTile(
                          title: Text("New order",style: Theme.of(context).textTheme.display1),
                          leading: Icon(Icons.shopping_basket,color:Colors.blueGrey ,size: 5*SizeConfig.heightMultiplier),
                        ),
                      ),

                      Divider(color: Colors.blueGrey,),

                      //history

                      InkWell(
                        child: ListTile(
                          title: Text("My order",style: Theme.of(context).textTheme.display1),
                          leading: Icon(Icons.history,color:Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                        ),
                      ),

                      Divider(color: Colors.blueGrey),


                      //details
                      InkWell(
                        onTap: (){

                       //   Navigator.of(context).pop();
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Myaccount()));
                          },
                        child: ListTile(
                          title: Text("My account",style: Theme.of(context).textTheme.display1),
                          leading: Icon(Icons.person,color: Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                        ),),
                      Divider(color: Colors.blueGrey),


                      //cart
                      InkWell(
                        onTap: (){
                          // Navigator.of(context).pop();
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskQ()));
                        },
                        child: ListTile(
                          title: Text(" Favourite",style: Theme.of(context).textTheme.display1,),
                          leading: Icon(Icons.favorite,color: Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                        ),
                      ),

                      Divider(color: Colors.blueGrey,),




                      //logout
                      InkWell(
                        onTap: ()async{
                          await _auth.signOut(context);
                        },
                        child: ListTile(
                          title: Text("Logout",style: Theme.of(context).textTheme.display1),
                          leading: Icon(Icons.arrow_back,color: Colors.blueGrey,size: 5*SizeConfig.heightMultiplier),
                        ),
                      ),
                    ],
                  ),),),
              appBar: _customAppBar(_key,context),
              body: ListView(
                children: <Widget>[

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
                  borderRadius: BorderRadius.circular(3*SizeConfig.heightMultiplier),
                  elevation: 7.0,
                  child: InkWell(
                    onTap: (){
                     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Storehome()));
                    },
                    child: Container(
                      height: 6.7*SizeConfig.heightMultiplier,
                      width: 15*SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                          color: Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(3*SizeConfig.heightMultiplier),
                          border: Border.all(
                              color:Color(0xFF185a9d),
                              style: BorderStyle.solid,
                              width: 2.0
                          )
                      ),
                      child: Center(
                        child: Text("Shop now",
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



