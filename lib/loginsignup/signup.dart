import 'package:admin/Dashborad/Admindashbord.dart';
import 'package:admin/StaffDetails/searchstaff.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/mainpages/home.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:admin/services/authentication.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

String error = '';

class _SignupState extends State<Signup> {
  final AuthService _auth = AuthService();
  bool loading = false;

  String fullname = '';
  String email = '';
  String address = '';
  String password = '';
  String telenumber = '';
  String confirmpassword = '';
  String role = 'staff';

  bool _showPassword = false;

  //initially password is obscure
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/mainpages/mm.jpg"),
                                  fit: BoxFit.fill)),
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
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => AdminPanel()));}
                          ),
                        ),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 15 * SizeConfig.heightMultiplier,
                                  bottom: 5 * SizeConfig.heightMultiplier,
                                  left: 6 * SizeConfig.heightMultiplier,
                                  right: 6 * SizeConfig.heightMultiplier),
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



                                  // password
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 18,
                                    ),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Container(
                                        child: new Center(
                                          child: new TextFormField(
                                            controller: _pass,
                                            decoration: new InputDecoration(
                                              errorStyle:Theme.of(context).textTheme.display1.copyWith(color: Colors.red,
                                                  fontSize: 12.0) ,
                                              labelText: "Password",
                                              prefixIcon: Icon(Icons.vpn_key,
                                                  color: Colors.blueGrey),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _togglevisibility();
                                                },
                                                child: Icon(
                                                  _showPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                            ),
                                              validator: (input) => input.length<6
                                                  ? 'Please type password with six character here'
                                                  : null,
                                            onChanged: (input) {
                                              setState(() {
                                                password = input;
                                              });
                                            },
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            obscureText: !_showPassword,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //confirm password

                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 18,
                                    ),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Container(
                                        child: new Center(
                                          child: new TextFormField(
                                            controller: _confirmPass,
                                            decoration: new InputDecoration(
                                              labelText: "Confirm Password",
                                              prefixIcon: Icon(Icons.vpn_key,
                                                  color: Colors.blueGrey),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  _togglevisibility();
                                                },
                                                child: Icon(
                                                  _showPassword
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fillColor: Colors.white,
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),

                                              ),
                                            ),
                                            validator: (input) =>
                                                input != _pass.text
                                                    ? 'Password does not match'
                                                    : null,
                                            onChanged: (input) {
                                              setState(() {
                                                confirmpassword = input;
                                              });
                                            },
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                            obscureText: !_showPassword,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "staff",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                          ),
                                          leading: Radio(
                                            value: 'staff',
                                            activeColor: Colors.white,
                                            groupValue: role,
                                            onChanged: (input) {
                                              setState(() {
                                                role = input;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "admin",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                          ),
                                          leading: Radio(
                                            value: 'admin',
                                            activeColor: Colors.white,
                                            groupValue: role,

                                            onChanged: (input) {
                                              setState(() {
                                                role = input;
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),


                                  // button
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 7 * SizeConfig.heightMultiplier,
                                      bottom: 3 * SizeConfig.heightMultiplier,
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      elevation: 4.0,
                                      child: InkWell(
                                        onTap: () async{
                                          print(role);
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              loading = true;
                                            });


                                            dynamic result =  await _auth
                                                  .registerWithEmailAndPassword(
                                                  email,
                                                  password,
                                                  role,
                                                  context);

                                            if (result==null){
                                              setState(() {
                                                loading=false;}
                                              );}else{
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20.0),
                                                      ),
                                                      child: Container(
                                                        height: 150.0,
                                                        child: Column(
                                                          children: <
                                                              Widget>[
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: 20.0),
                                                              child:
                                                              Text(
                                                                "Account is created",
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .display1,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.all(
                                                                  30.0),
                                                              child:
                                                              Material(
                                                                borderRadius:
                                                                BorderRadius.circular(20.0),
                                                                elevation:
                                                                4.0,
                                                                child: InkWell(
                                                                    borderRadius: BorderRadius.circular(20.0),
                                                                    onTap: () {
                                                                      UserManagment().authorizedAccess(context);
                                                                    },
                                                                    child: buttonContainer(context, "okay", 43.0, 100.0)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            }


                                             if (loading==false){
                                              setState(() {
                                                error='Please check your email and password';
                                              });
                                            }



                                          }

                                        },
                                        child: buttonContainerWithBlue(context, "Sign up", 43, null)

                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Text('Already staff have account?',style:Theme.of(context)
                                            .textTheme
                                            .subhead,),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StaffSearch(search: 'staff')));
                                          },
                                          child: Text('Search Staff',style:Theme.of(context)
                                              .textTheme
                                              .subhead.copyWith(color:Color(
                                              0xFF185a9d ),fontWeight: FontWeight.bold)
                                    ,
                                          ) ),
                                      )],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Center(child: Text(error,style: Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 15),)),



                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
