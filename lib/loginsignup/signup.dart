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
  String role = '';

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
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF185a9d),
                                  const Color(0xFF43cea2)
                                ],
                              ),
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
                              UserManagment().authorizedAccess(context);
                            },
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
                                              decoration: new InputDecoration(
                                                labelText: "Email",
                                                prefixIcon: Icon(Icons.email,
                                                    color: Colors.blueGrey),
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                                fillColor: Colors.white,
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          22.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          22.0),
                                                ),
                                              ),
                                              validator: (input) => input
                                                      .isEmpty
                                                  ? 'Please type your email here'
                                                  : null,
                                              onChanged: (input) {
                                                setState(() {
                                                  email = input;
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),
                                  Center(
                                      child: Text(
                                    error,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                            color: Colors.red, fontSize: 15),
                                  )),

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
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        22.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        22.0),
                                              ),
                                            ),
                                            validator: (input) {
                                              Pattern pattern =
                                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
                                              RegExp regex =
                                                  new RegExp(pattern);
                                              if (input.length < 6) {
                                                return 'Your password needs to be at least 6 characters';
                                              } else {
                                                if (!regex.hasMatch(input))
                                                  return 'Your password should contain at least one upper case,\n'
                                                      ' one lower case'
                                                      ' and one digit';
                                                else
                                                  return null;
                                              }
                                            },
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
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        22.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF185a9d),
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        22.0),
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
                                        onTap: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              loading = true;
                                            });
                                            dynamic result = await _auth
                                                .registerWithEmailAndPassword(
                                                    email,
                                                    password,
                                                    role,
                                                    context);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child: Container(
                                                      height: 150.0,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20.0),
                                                            child: Text(
                                                              "Account is created",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .display1,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    30.0),
                                                            child: Material(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              elevation: 4.0,
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                                onTap: () {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Homepage()),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40.0,
                                                                  width: 100.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                      colors: [
                                                                        const Color(
                                                                            0xFF185a9d),
                                                                        const Color(
                                                                            0xFF43cea2)
                                                                      ],
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                        "okay",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subhead),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });

                                            if (result == null) {
                                              setState(() {
                                                error =
                                                    "please supply a vaild email";
                                                loading = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF185a9d),

                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Center(
                                            child: Text("Sign up",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
