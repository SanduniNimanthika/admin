import 'dart:ui';
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
              return Container(
                child: Stack(children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF185a9d),
                            const Color(0xFF43cea2)
                          ],
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Center(
                    child: Image(
                      image: AssetImage("images/mainpages/familyhealth.png"),
                      height: 83.3 * SizeConfig.imageSizeMultiplier,
                      width: 83.3 * SizeConfig.imageSizeMultiplier,
                    ),
                  ),
                  Container(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, bottom: 50.0, top: 80.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.blueGrey.withOpacity(0.3),
                          child: ListView(
                            children: <Widget>[
                              ListTile(
                                contentPadding: EdgeInsets.all(
                                    2 * SizeConfig.heightMultiplier),
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: Text(profile.fullname,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(
                                    2 * SizeConfig.heightMultiplier),
                                leading: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                title: Text(profile.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(
                                    2 * SizeConfig.heightMultiplier),
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                title: Text(profile.telenumber,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(
                                    2 * SizeConfig.heightMultiplier),
                                leading: Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                                title: Text(profile.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subhead
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 5 * SizeConfig.heightMultiplier,
                                    bottom: 5 * SizeConfig.heightMultiplier),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      elevation: 7.0,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(20.0),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context) => Setting()));
                                        },
                                        child: Container(
                                          height: 40.0,
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFE3F2FD),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                  color: Color(0xFF185a9d),
                                                  style: BorderStyle.solid,
                                                  width: 2.0)),
                                          child: Center(
                                            child: Text("Back",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead
                                                    .copyWith(
                                                        color:
                                                            Color(0xFF185a9d))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
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
                                        child: Container(
                                          height:
                                              6.7 * SizeConfig.heightMultiplier,
                                          width:
                                              20 * SizeConfig.heightMultiplier,
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
                                                3 *
                                                    SizeConfig
                                                        .heightMultiplier),
                                          ),
                                          child: Center(
                                            child: Text("Edit",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                ]),
              );
            }),
      ),
    );
  }
}
