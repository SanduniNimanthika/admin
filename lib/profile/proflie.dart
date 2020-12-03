import 'dart:ui';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/profile/Editprofile.dart';
import 'package:admin/module/staff.dart';
import 'package:admin/profile/setting&privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:provider/provider.dart';
import 'package:admin/database/staffdatabase.dart';

class Myaccount extends StatefulWidget {
  @override
  _MyaccountState createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final staff = Provider.of<Staff>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<Staff>(
            stream: DatabaseService(uid: staff.staffkey).profileData,
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
                          color: Colors.white,
                        ), onPressed: (){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Setting()));}



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
                                      gradient: linearcolor()
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
                  padding: const EdgeInsets.only(top:28.0),
                  child: ListView(
                    children: <Widget>[
                      listBar(context, profile.fullname,  Icons.person,),
                     Divider(),
                     listBar(context, profile.email,  Icons.email,),
                      Divider(),
                     listBar(context,profile.telenumber,  Icons.phone,),
                      Divider(),
                      listBar(context,profile.address, Icons.home,),

                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            top: 5 * SizeConfig.heightMultiplier,
                            ),
                        child: Material(
                          borderRadius: BorderRadius.circular(
                              5 * SizeConfig.heightMultiplier),
                          elevation: 4.0,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EditProfile();
                                  });
                            },
                            child:buttonContainer(context, 'Edit Profille', 43, null)

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
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