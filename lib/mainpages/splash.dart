import 'dart:async';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:admin/services/usermanagment.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    startTimer();
  }
  startTimer()async{
      var duration=Duration(seconds:4);
      return Timer(duration,route);
  }
      route(){
    Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context)=>UserManagment().handleAuth(),));
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
            tileMode: TileMode.repeated,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40*SizeConfig.imageSizeMultiplier,
                child:Image.asset("images/mainpages/loading.png") ,
              ),


              Text("Welcome to Medicare",style: Theme.of(context).textTheme.title.copyWith(fontFamily:"Quintessential",color: Color(0xFFE3F2FD),letterSpacing: 2 ),)

            ],
          ),
        ),
      ),
    );
  }
}
