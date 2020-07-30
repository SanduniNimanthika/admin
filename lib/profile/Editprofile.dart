import 'package:flutter/material.dart';
import 'package:admin/database/staffdatabase.dart';
import 'package:admin/profile/Editprofile.dart';
import 'package:admin/module/staff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:provider/provider.dart';
import 'package:admin/database/staffdatabase.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  final DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String _currentName;

  String _currenttelenumber;
  String _currentaddress;
  Widget build(BuildContext context) {
    final staff = Provider.of<Staff>(context, listen: false);
    return StreamBuilder<Staff>(
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
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: Text('Edit Profile',
                                  style: Theme.of(context).textTheme.subtitle),
                            ),
                            TextFormField(
                                initialValue: profile.fullname,
                                decoration: new InputDecoration(
                                  labelText: "Full Name",
                                  labelStyle:
                                      Theme.of(context).textTheme.display1,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors.blueGrey),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius:
                                        new BorderRadius.circular(22.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF185a9d),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    borderRadius:
                                        new BorderRadius.circular(22.0),
                                  ),
                                ),
                                validator: (input) => input.isEmpty
                                    ? 'Please type your full name here'
                                    : null,
                                onChanged: (input) {
                                  setState(() {
                                    _currentName = input;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.display1),

                            // TP NUMBER

                            Padding(
                              padding: EdgeInsets.only(
                                top: 5 * SizeConfig.heightMultiplier,
                              ),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(
                                        initialValue: profile.telenumber,
                                        decoration: new InputDecoration(
                                          labelText: "Telephone Number",
                                          prefixIcon: Icon(Icons.phone,
                                              color: Colors.blueGrey),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                        ),
                                        validator: (input) => input.length != 10
                                            ? 'Your telephone number is incorrect'
                                            : null,
                                        onChanged: (input) {
                                          setState(() {
                                            _currenttelenumber = input;
                                          });
                                        },
                                        keyboardType: TextInputType.phone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
                            ),

                            //Address
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5 * SizeConfig.heightMultiplier,
                              ),
                              child: Container(
                                child: new Center(
                                    child: new TextFormField(
                                        initialValue: profile.address,
                                        decoration: new InputDecoration(
                                          labelText: "Address",
                                          prefixIcon: Icon(Icons.home,
                                              color: Colors.blueGrey),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .display1,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF185a9d),
                                                style: BorderStyle.solid,
                                                width: 1),
                                            borderRadius:
                                                new BorderRadius.circular(22.0),
                                          ),
                                        ),
                                        validator: (input) => input.isEmpty
                                            ? 'Please type your address here'
                                            : null,
                                        onChanged: (input) {
                                          setState(() {
                                            _currentaddress = input;
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1)),
                              ),
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
                                    if (_formKey.currentState.validate()) {
                                      await DatabaseService(uid: staff.staffkey)
                                          .profileupdate(
                                        profile.email,profile.role,
                                              _currentName ?? profile.fullname,
                                              _currentaddress ??
                                                  profile.address,
                                        _currenttelenumber ??
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
