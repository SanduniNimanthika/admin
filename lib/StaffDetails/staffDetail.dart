import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/database/staffdatabase.dart';
import 'package:admin/module/staff.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffDetail extends StatefulWidget {
  final String staffuid;
  StaffDetail({Key key, @required this.staffuid}) : super(key: key);
  @override
  _StaffDetailState createState() => _StaffDetailState(staffuid: staffuid);
}

class _StaffDetailState extends State<StaffDetail> {
  final String staffuid;
  _StaffDetailState({Key key, @required this.staffuid});
  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final staff = Provider.of<Staff>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<Staff>(
                stream: DatabaseService(uid: staffuid).profileData,
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
                  return NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                              expandedHeight:
                                  MediaQuery.of(context).size.height / 5 * 2,
                              floating: false,
                              pinned: true,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  UserManagment().authorizedAccess(context);
                                },
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              flexibleSpace: FlexibleSpaceBar(
                                  background: ClipPath(
                                      clipper: ClippingPath(),
                                      child: Container(
                                        height:
                                             (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5 *
                                                2),

                                        width:
                                            MediaQuery.of(context).size.width,
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
                                        child: Center(
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                'https://c-sf.smule.com/z0/account/icon/v4_defpic.png',
                                              ),
                                            ),
                                          ),
                                        ),
                                      )))),
                        ];
                      },
                      body: Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: ListView(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child: listBar(context, profile.fullname,
                                    Icons.account_circle)),
                            Divider(),
                            listBar(context, profile.address, Icons.home),

                            Divider(),
                            listBar(context, profile.telenumber, Icons.phone),

                            Divider(),
                            listBar(context, profile.email, Icons.email),
                            Divider(),
                            listBar(context, profile.role, Icons.beenhere),

                            // button
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 34, bottom: 20, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(
                                            5 * SizeConfig.heightMultiplier),
                                        elevation: 4.0,
                                        child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return EditProfileRole(staffuid: staffuid,);
                                                  });

                                            },
                                            child: buttonContainer(
                                                context, 'Edit', 43, null)),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        borderRadius:
                                        BorderRadius.circular(
                                            20),
                                        elevation: 7.0,
                                        child: InkWell(
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
                                                                          child: Container(
                                                                            height: 40,
                                                                            width: 100,
                                                                            decoration: BoxDecoration(
                                                                                color: Color(
                                                                                    0xFFE3F2FD),
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    20),
                                                                                border: Border.all(
                                                                                    color: Color(
                                                                                        0xFF185a9d),
                                                                                    style:
                                                                                    BorderStyle
                                                                                        .solid,
                                                                                    width: 2.0)),
                                                                            child: Center(
                                                                              child: Text("Back",
                                                                                  style: Theme.of(
                                                                                      context)
                                                                                      .textTheme
                                                                                      .subhead
                                                                                      .copyWith(
                                                                                      color: Color(
                                                                                          0xFF185a9d))),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Material(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                        elevation: 7.0,
                                                                        child: InkWell(
                                                                          onTap: () async {

                                                                            //delete auth

//delete database
                                                                            await DatabaseService(
                                                                                uid: staffuid)
                                                                                .deleteuser();
                                                                            UserManagment().authorizedAccess(context);




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
                                                                                border: Border.all(
                                                                                    color: Colors
                                                                                        .white,
                                                                                    style:
                                                                                    BorderStyle
                                                                                        .solid,
                                                                                    width: 2.0)),
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
                                          child: Container(
                                            height: 43,


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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                })));
  }
}

class ClippingPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, size.height / 1.5);
    path.lineTo(
      size.width,
      0.0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldCliper) => false;
}





class EditProfileRole extends StatefulWidget {
  final String staffuid;
  EditProfileRole({Key key, @required this.staffuid}) : super(key: key);
  @override
  _EditProfileRoleState createState() => _EditProfileRoleState(staffuid: staffuid);
}

class _EditProfileRoleState extends State<EditProfileRole> {
  final String staffuid;
  _EditProfileRoleState({Key key, @required this.staffuid}) ;
  final DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  
  String _currentrole = '';
  @override
  Widget build(BuildContext context) {
    final staff = Provider.of<Staff>(context, listen: false);
    return StreamBuilder<Staff>(
        stream: DatabaseService(uid: staffuid).profileData,
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
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Text('Edit Profile',
                                  style: Theme.of(context).textTheme.subtitle),
                            ),

                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "staff",
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1,
                                    ),
                                    leading: Radio(
                                      value: 'staff',
                                      activeColor: Colors.grey,
                                      groupValue: _currentrole,
                                      onChanged: (input) {
                                        setState(() {
                                          _currentrole = input;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "admin",
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1,
                                    ),
                                    leading: Radio(
                                      value: 'admin',
                                      activeColor: Colors.grey,
                                      groupValue: _currentrole,


                                      onChanged: (input) {
                                        setState(() {
                                          _currentrole = input;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),


                            Padding(
                              padding: EdgeInsets.only(
                                top: 7 * SizeConfig.heightMultiplier,
                                bottom: 3 * SizeConfig.heightMultiplier,
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(
                                    5 * SizeConfig.heightMultiplier),
                                elevation: 4.0,
                                child: InkWell(
                                  onTap: () async {
                                    print(_currentrole);
                                    if (_formKey.currentState.validate()) {
                                      await DatabaseService(uid: staffuid)
                                          .profileupdate(
                                        profile.email,_currentrole ?? profile.role,
                                         profile.fullname,

                                            profile.address,

                                            profile.telenumber,
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    height: 6.7 * SizeConfig.heightMultiplier,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          const Color(0xFF185a9d),
                                          const Color(0xFF43cea2)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          5 * SizeConfig.heightMultiplier),
                                    ),
                                    child: Center(
                                      child: Text("Save",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 5 * SizeConfig.heightMultiplier),
                              child: Material(
                                borderRadius: BorderRadius.circular(
                                    4 * SizeConfig.heightMultiplier),
                                elevation: 7.0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 6.7 * SizeConfig.heightMultiplier,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFE3F2FD),
                                        borderRadius: BorderRadius.circular(
                                            4 * SizeConfig.heightMultiplier),
                                        border: Border.all(
                                            color: Color(0xFF185a9d),
                                            style: BorderStyle.solid,
                                            width: 2.0)),
                                    child: Center(
                                      child: Text("Cancle",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead
                                              .copyWith(
                                              color: Color(0xFF185a9d))),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])),
                    )),
              ),
            ),
          );
        });
  }
}
