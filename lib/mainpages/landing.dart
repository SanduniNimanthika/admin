
import 'package:admin/mainpages/home.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/module/staff.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {

    final staff = Provider.of<Staff>(context);

    if(staff == null){
      return  Homepage();
    }else{
      return  Container(
        //child: AdminPanel(),

        child:
        UserManagment().authorizedAccess(context),
      );

    }
  }
}

