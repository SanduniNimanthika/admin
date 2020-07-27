import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:medicare/services/authentication.dart';
//import 'package:medicare/mainpages/forgotpass.dart';

//mainpages
import "package:admin/mainpages/home.dart";
import "package:admin/loginsignup/signup.dart";
import 'package:admin/commanpages/loading.dart';

//commanpages
import 'package:admin/commanpages/configue.dart';
class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}
String error='';

class _SigninState extends State<Signin> {

 // final AuthService _auth=AuthService();

  String email,password;

  bool loading=false;


  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:loading?Loading(): Scaffold(
          appBar: _customAppBar(context),
          body:SingleChildScrollView(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding:EdgeInsets.only(top:3*SizeConfig.heightMultiplier ,left:5*SizeConfig.heightMultiplier ),
                                child: Row(
                                  children: <Widget>[
                                    Text("W",
                                        style:Theme.of(context).textTheme.headline.copyWith(fontSize: 60,letterSpacing: 10)),
                                    Text("elcome",
                                        style:Theme.of(context).textTheme.headline.copyWith(fontSize: 40,letterSpacing: 1)),


                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left:15*SizeConfig.heightMultiplier ),
                                    child: Text("B",
                                        style:Theme.of(context).textTheme.headline.copyWith(fontSize: 60,letterSpacing: 10)),
                                  ),
                                  Text("ack",
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
                Container(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only (bottom: 7*SizeConfig.heightMultiplier,
                          left: 6*SizeConfig.heightMultiplier,right: 6*SizeConfig.heightMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          //Email ADDRESS
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

                          // password
                          Padding(
                            padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,bottom:3*SizeConfig.heightMultiplier ),
                            child: Container(
                              child: new Center(
                                child: new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Password",


                                    prefixIcon: Icon(Icons.vpn_key,color:Colors.blueGrey),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _togglevisibility();
                                      },
                                      child: Icon(
                                        _showPassword ? Icons.visibility : Icons
                                            .visibility_off, color: Colors.blueGrey,),
                                    ),

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


                                  validator: (input)=>input.length<6?'Your password needs to be at least 6 characters':null,
                                  onChanged: (input){
                                    setState(() {
                                      password=input;
                                    });
                                  },
                                  style: Theme.of(context).textTheme.display1,
                                  obscureText: !_showPassword,

                                ),
                              ),
                            ),
                          ),


                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: (){
                           //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Forgotpass()));
                              },
                              child: Text("Forgot password?",
                                  style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d) )),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only (top:7*SizeConfig.heightMultiplier,bottom: 2*SizeConfig.heightMultiplier,),
                            child: Material(
                              borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                              elevation: 4.0,
                              child: InkWell(
                                onTap: ()async{
                               //   if(_formKey.currentState.validate()){
                               //     setState(() {
                                //      loading=true;
                                //    });
                                  //  dynamic result =await _auth.signInWithEmailAndPassword(email, password,context);
                                    //if (result==null){
                                      //setState(() {

                                        //loading=false;}
                                    //  );

                                //    } if (loading==false){
                                //      setState(() {
                                //        error='Please check your email and password';
                               //       });
                               //     }
                                 // }
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],),
                                    borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                                  ),
                                  child: Center(
                                    child: Text("Login",
                                        style:Theme.of(context).textTheme.subhead),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      //    Center(child: Text(error,style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 15),)),





                          Padding(
                            padding:  EdgeInsets.only(top: 3*SizeConfig.heightMultiplier),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Don't have an account?\t",
                                  style: Theme.of(context).textTheme.display1,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));
                                  },
                                  child: Text("Create an account",
                                      style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d) )),
                                ),
                              ],
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}






Widget  _customAppBar(context){
  return PreferredSize(
    preferredSize: Size.fromHeight(12*SizeConfig.heightMultiplier),
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Homepage()));

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
