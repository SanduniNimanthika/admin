import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/loginsignup/forgotpass.dart';
import 'package:admin/mainpages/landing.dart';
import 'package:admin/profile/proflie.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin/services/authentication.dart';
import 'package:flutter/rendering.dart';
import 'package:admin/mainpages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin/database/staffdatabase.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final AuthService _auth = AuthService();
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

                    background: Image.asset(
                      "images/dashbord/privacy_200674785-391x250.jpeg",
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
                  child:listBar(context,  "Update your personal inflormation", Icons.account_circle)

                ),
              ),
              Divider(),
              InkWell(
                onTap: (){
                 // Navigator.push(
                   //   context,
                   //   MaterialPageRoute(
                   //   builder: (context) => Forgotpass()));
                },
                child: listBar(context,  "Change your password", Icons.vpn_key)

              ),
              Divider(),
              InkWell(
                onTap: ()async {
                  await _auth.signOut(context);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              LandingPage()));

                },
                child:listBar(context, "Log out", Icons.arrow_back)

              ),
              Divider(),
              InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 0.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: SingleChildScrollView(
                                child: Container(
                                    color: Color(0xFFE3F2FD),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20.0, bottom: 20.0),
                                          child: Text('Delete Account',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 20.0),
                                          child: Text(
                                              'After you delete an account, it\'s permanently deleted. Accounts can\'t be undeleted.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  color: Colors.red)),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Material(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20),
                                                elevation: 7.0,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child:buttonContainerWithBlue(context,"Back", 43,100)

                                                ),
                                              ),
                                              Material(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20),
                                                elevation: 7.0,
                                                child: InkWell(
                                                  onTap: () async {
                                                    FirebaseUser user =
                                                    await FirebaseAuth
                                                        .instance
                                                        .currentUser();
                                                    await DatabaseService(
                                                        uid: user.uid)
                                                        .deleteuser();
                                                    user.delete();

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context) =>
                                                                LandingPage()));



                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20),
                                                        ),
                                                    child: Center(
                                                      child: Text("Delete",
                                                          style: Theme.of(
                                                              context)
                                                              .textTheme
                                                              .subhead
                                                              .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    )),
                              ),
                            ),
                          );
                        });
                  },
                  child:listBar(context,  "Delete your Account", Icons.delete)),

              Divider(),
            ],
          )
        ),
      )
    );
  }
}
