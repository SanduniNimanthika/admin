import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/loginsignup/forgotpass.dart';
import "package:admin/mainpages/home.dart";

import 'package:admin/commanpages/loading.dart';
import 'package:admin/commanpages/configue.dart';
class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}
String error='';

class _SigninState extends State<Signin> {

  final AuthService _auth=AuthService();

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
          body:SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/mainpages/mm.jpg"),
                      fit: BoxFit.fill

                    )
                  ),
                ),
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: linearcolor()
                    ),

                  ),
                ),

                Container(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only (top:180.0,left: 6*SizeConfig.heightMultiplier,right: 6*SizeConfig.heightMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[

                          //Email ADDRESS
                          Opacity(
                            opacity: 0.8,
                            child: Container(
                              child: new Center(
                                  child: new TextFormField(
                                      decoration:inputDecaration(context, "Email", Icons.email),

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
                          ),

                          // password
                          Padding(
                            padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,bottom:3*SizeConfig.heightMultiplier ),
                            child: Opacity(
                              opacity: 0.8,
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0),
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

                                      labelStyle:Theme.of(context).textTheme.display1.copyWith(color: Colors.black54),


                                      filled: true,
                                      fillColor: Colors.white,

                                      focusedBorder:OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:Color(0xFF185a9d),
                                            style: BorderStyle.solid,
                                            width: 1
                                        ),

                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:Color(0xFF185a9d),
                                            style: BorderStyle.solid,
                                            width: 1
                                        ),

                                      ),
                                    ),


                                    validator: (input)=>input.isEmpty?'Please enter your password':null,
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
                          ),


                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: (){
                              //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Forgotpass()));
                              },
                              child: Text("Forgot password?",
                                  style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d),fontWeight: FontWeight.bold )),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only (top:7*SizeConfig.heightMultiplier,bottom: 2*SizeConfig.heightMultiplier,),
                            child: Material(
                              borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                              elevation: 4.0,
                              child: InkWell(
                                onTap: ()async{
                                  if(_formKey.currentState.validate()){
                                    setState(() {
                                      loading=true;
                                    });
                                    dynamic result =await _auth.signInWithEmailAndPassword(email, password,context);


                                    if (result==null){
                                      setState(() {
                                        loading=false;}
                                      );


                                    } if (loading==false){
                                      setState(() {
                                        error='Please check your email and password';
                                      });
                                    }
                                    if(result!=null){
                                      UserManagment().authorizedAccess(context);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:Color(0xFF185a9d) ,

                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Center(
                                    child: Text("Login",
                                        style:Theme.of(context).textTheme.subhead),
                                  ),
                                ),
                              ),
                            ),
                          ),
                            Center(child: Text(error,style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 15),)),









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


