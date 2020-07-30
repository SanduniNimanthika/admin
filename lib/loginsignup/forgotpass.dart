import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin/commanpages//configue.dart';
import 'package:admin/loginsignup/login.dart';
class Forgotpass extends StatefulWidget {
  @override
  _ForgotpassState createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // appBar:_customAppBar(context) ,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Container(
                constraints: BoxConstraints(
                  maxHeight: 45* SizeConfig.heightMultiplier,),
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: ClippingPath(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.bottomRight,
                            colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:EdgeInsets.only(top:3*SizeConfig.heightMultiplier ,left:3*SizeConfig.heightMultiplier ),
                              child: Row(
                                children: <Widget>[
                                  Text("R",
                                      style:Theme.of(context).textTheme.headline.copyWith(fontSize: 60,letterSpacing: 10)),
                                  Text("eset",
                                      style:Theme.of(context).textTheme.headline.copyWith(fontSize: 40,letterSpacing: 1)),


                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left:10*SizeConfig.heightMultiplier ),
                                  child: Text("P",
                                      style:Theme.of(context).textTheme.headline.copyWith(fontSize: 60,letterSpacing: 10)),
                                ),
                                Text("assword",
                                    style:Theme.of(context).textTheme.headline.copyWith(fontSize: 40,letterSpacing: 1)
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              BODY(),

            ],
          ),
        ),
      ),
    );
  }
}
class BODY extends StatefulWidget {
  @override
  _BODYState createState() => _BODYState();
}

class _BODYState extends State<BODY> {
  String email;

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[


            Container(
              child: new Center(
                  child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email,color:Colors.blueGrey),
                        labelStyle:Theme.of(context).textTheme.display1,
                        fillColor: Colors.white,
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                              color:Color(0xFF185a9d),
                              style: BorderStyle.solid,
                              width: 1
                          ),
                          borderRadius: new BorderRadius.circular(22.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:Color(0xFF185a9d),
                              style: BorderStyle.solid,
                              width: 1
                          ),
                          borderRadius: new BorderRadius.circular(22.0),
                        ),
                      ),
                      validator: (input)=>input.isEmpty?'Please type your email here':null,
                      onChanged: (input){
                        setState(() {
                          email=input;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.display1
                  )
              ),
            ),


            Text(
              "We will mail you a link...,Please click that link to reset your passwod",style: Theme.of(context).textTheme.display1.copyWith(fontSize: 12),
            ),


            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 4.0,
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()){
                    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                    _showMyDialog(context);

                  }
                },
                child: Container(
                  height: 6.7*SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                    borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                  ),
                  child: Center(
                    child: Text("Reset password",
                        style:Theme.of(context).textTheme.subhead),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Please check your emails',style: Theme.of(context).textTheme.display1,),

        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signin()));
            },
          ),
        ],
      );
    },
  );
}



Widget  _customAppBar(context){
  return PreferredSize(
    preferredSize: Size.fromHeight(10*SizeConfig.heightMultiplier),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left:2.2*SizeConfig.widthMultiplier,right:2.2*SizeConfig.widthMultiplier ),
        child: Center(
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signin()));
                },),
            ],
          ),
        ),
      ),),
  );
}



class ClippingPath extends CustomClipper<Path>{
  @override
  Path getClip (Size size){
    var path= Path();
    path.lineTo(0.0, size.height/1.2);
    var firstControlPoint=Offset(size.width/2,size.height/3);
    var firstEndPoint=Offset(size.width/2.25,size.height/1.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint=Offset(size.width-(size.width/3.25),size.height/3.0);
    var secondEndPoint=Offset(size.width,size.height/1.2);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height/1.5);
    path.lineTo(size.width,0.0,);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldCliper)=>false;
}