import 'package:admin/profile/proflie.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/material.dart';
class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height/3,
                floating: false,
                pinned: true,
                leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Color(0xFF185a9d),), onPressed: () {
                  UserManagment().authorizedAccess(context);
                },),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title:Text("Account Security",
            style: Theme.of(context).textTheme.subtitle.copyWith(color:Color(0xFF185a9d), )
            ),


                flexibleSpace: FlexibleSpaceBar(

                    background: Image.network(
                      "http://www.oecd.org/media/oecdorg/directorates/directorateforsciencetechnologyandindustry/digital/privacy_200674785-391x250.jpeg",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body:Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Myaccount()));
                  },
                  child: ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(
                      "Update your personal inflormation",style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                ),
              ),
              Divider(),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.vpn_key),
                  title: Text(
                    "Change your password",style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text(
                    "Delete your account",style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
              Divider(),
            ],
          )
        ),
      )
    );
  }
}
