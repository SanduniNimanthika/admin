import 'package:admin/StaffDetails/searchstaff.dart';
import 'package:admin/UserDetail/ordertab.dart';
import 'package:admin/order/odertab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/database/user.dart';
import 'package:admin/module/user.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/services/usermanagment.dart';

class UserDetail extends StatefulWidget {
  final String useruid;
  final String back;
  UserDetail({Key key, @required this.useruid,@required this.back}) : super(key: key);
  @override
  _UserDetailState createState() => _UserDetailState(useruid: useruid,back: back);
}

class _UserDetailState extends State<UserDetail> {
  final String useruid;
  final String back;
  _UserDetailState({Key key, @required this.useruid,@required this.back});
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();
  @override
  Widget build(BuildContext context) {
 
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<User>(
                stream: DatabaseServiceUser(uid: useruid).profileData,
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
                                  if(back=='order'){
                                    return Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderTab()));
                                  }else{ return
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StaffSearch(search: null)));
                                    }}
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
                            listBar(context, profile.hometown, Icons.location_on),

                            Divider(),
                            listBar(context, profile.telenumber, Icons.phone),

                            Divider(),
                            listBar(context, profile.email, Icons.email),

                            // button
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 34, bottom: 20, left: 15, right: 15),
                              child: Material(
                                borderRadius: BorderRadius.circular(
                                    5 * SizeConfig.heightMultiplier),
                                elevation: 4.0,
                                child: InkWell(
                                    onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Tabcontroller(selectedPage: 1,useremail:profile.email,useruid:useruid)));

                                    },
                                    child: buttonContainer(
                                        context, 'View order history', 43, 150)),
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
