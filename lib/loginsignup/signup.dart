import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/mainpages/home.dart';
import 'package:admin/loginsignup/login.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:admin/services/authentication.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}
String error='';
class _SignupState extends State<Signup> {

  final AuthService _auth=AuthService();
  bool loading=false;

  //initially password is obscure
  String fullname='';
  String email='';
  String address='';
  String password='';
  String telenumber='';
  String confirmpassword='';

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }


  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading?Loading():Scaffold(
        appBar:_customAppBar(context) ,
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

                    Padding(
                      padding:EdgeInsets.only(top:3*SizeConfig.heightMultiplier ,left:5*SizeConfig.heightMultiplier ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("C",
                                  style:Theme.of(context).textTheme.headline.copyWith(fontSize: 60,letterSpacing: 10)),
                              Text("reate",
                                  style:Theme.of(context).textTheme.headline.copyWith(fontSize: 40,letterSpacing: 1)),

                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left:3*SizeConfig.heightMultiplier ),
                                child: Text("A",
                                    style:Theme.of(context).textTheme.headline.copyWith(fontSize: 60,letterSpacing: 10)),
                              ),
                              Text("ccount",
                                  style:Theme.of(context).textTheme.headline.copyWith(fontSize: 40,letterSpacing: 1)),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only (bottom: 5*SizeConfig.heightMultiplier,
                        left: 6*SizeConfig.heightMultiplier,right: 6*SizeConfig.heightMultiplier),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        //name
                        new Container(
                          child: new Center(
                              child: new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Full Name",labelStyle:Theme.of(context).textTheme.display1,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.person,color:Colors.blueGrey),


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
                                  validator: (input)=>input.isEmpty?'Please type your full name here':null,
                                  onChanged: (input){
                                    setState(() {
                                      fullname=input;
                                    });
                                  },

                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.display1
                              )
                          ),
                        ),

                        //Address
                        Padding(
                          padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,),
                          child: Container(
                            child: new Center(
                                child: new TextFormField(
                                    decoration: new InputDecoration(
                                      labelText: "Address",
                                      prefixIcon: Icon(Icons.home,color:Colors.blueGrey),
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
                                    validator: (input)=>input.isEmpty?'Please type your address here':null,
                                    onChanged: (input){
                                      setState(() {
                                        address=input;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                    style: Theme.of(context).textTheme.display1
                                )
                            ),
                          ),
                        ),


                        // TP NUMBER
                        Padding(
                          padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,),
                          child: Container(
                            child: new Center(
                                child: new TextFormField(
                                    decoration: new InputDecoration(
                                      labelText: "Telephone Number",
                                      prefixIcon: Icon(Icons.phone,color:Colors.blueGrey),
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
                                    validator: (input)=>input.length!=10?'Your telephone number is incorrect':null,
                                    onChanged: (input){
                                      setState(() {
                                        telenumber=input;
                                      });
                                    },

                                    keyboardType: TextInputType.phone,
                                    style: Theme.of(context).textTheme.display1
                                )
                            ),
                          ),
                        ),


                        //Email ADDRESS
                        Padding(
                          padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,),
                          child: Container(
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
                        ),
                        Center(child: Text(error,style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 15),)),



                        // password
                        Padding(
                          padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,),
                          child: Container(
                            child: new Center(
                              child: new TextFormField(
                                controller: _pass,
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
                                validator: (input) {
                                  Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                                  RegExp regex = new RegExp(pattern);
                                  if (input.length<6) {
                                    return 'Your password needs to be at least 6 characters';
                                  }else {
                                    if (!regex.hasMatch(input))
                                      return 'Your password should contain at least one upper case,\n'
                                          ' one lower case'
                                          ' and one digit';
                                    else
                                      return null;
                                  }
                                },

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


                        //confirm password

                        Padding(
                          padding:  EdgeInsets.only (top:5*SizeConfig.heightMultiplier,),
                          child: Container(
                            child: new Center(
                              child: new TextFormField(
                                controller: _confirmPass,
                                decoration: new InputDecoration(
                                  labelText: "Confirm Password",
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
                                validator: (input)=>input!= _pass.text?'Password does not match':null,
                                onChanged: (input){
                                  setState(() {
                                    confirmpassword=input;
                                  });
                                },
                                style: Theme.of(context).textTheme.display1,
                                obscureText: !_showPassword,

                              ),
                            ),
                          ),
                        ),





                        // button
                        Padding(
                          padding: EdgeInsets.only (top:7*SizeConfig.heightMultiplier,bottom: 3*SizeConfig.heightMultiplier,),
                          child: Material(
                            borderRadius: BorderRadius.circular(5*SizeConfig.heightMultiplier),
                            elevation: 4.0,
                            child: InkWell(
                              onTap: ()async{
                                if(_formKey.currentState.validate()){
                                  setState(() {
                                    loading=true;
                                  });
                                  dynamic result =await _auth.registerWithEmailAndPassword(email, password,fullname,telenumber,address,confirmpassword,context);
                                  if (result==null){
                                    setState(() {error="please supply a vaild email";
                                    loading=false;});
                                  }
                                }

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
                                  child: Text("Sign up",
                                      style:Theme.of(context).textTheme.subhead),
                                ),
                              ),
                            ),
                          ),
                        ),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account?\t",
                              style: Theme.of(context).textTheme.display1,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signin()));
                              },
                              child: Text("Login",
                                  style:Theme.of(context).textTheme.subhead.copyWith(color:Color(0xFF185a9d) )),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
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


