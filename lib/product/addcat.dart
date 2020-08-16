import 'package:admin/database/Catdatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/product/productcollection.dart';

class AddCat extends StatefulWidget {
  @override
  _AddCatState createState() => _AddCatState();
}



class _AddCatState extends State<AddCat> {
  bool loading = false;
  String catergory = '';
  String catergorysearchkey = '';

  CatergoryService _categoryService = CatergoryService();

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
                                  image:
                                      AssetImage("images/dashbord/backcat.jpg"),
                                  fit: BoxFit.fill)),
                        ),
                        Opacity(
                          opacity: 0.5,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductCollection()));
                            },
                          ),
                        ),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 35 * SizeConfig.heightMultiplier,
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
                                                labelText: "Catergory Name",
                                                prefixIcon: Icon(Icons.add,
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

                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFF185a9d),
                                                      style: BorderStyle.solid,
                                                      width: 1),

                                                ),

                                              ),

                                              validator: (input) {
                                                Pattern pattern =
                                                    r'^(?=.*?[A-Z])(?=.*?[a-z]).{2,}$';
                                                RegExp regex =
                                                new RegExp(pattern);
                                                if (input.isEmpty) {
                                                  return 'Please provide catergory name';
                                                } else {
                                                  if (!regex.hasMatch(input))
                                                    return 'You catergory name should be begin with capital letter';
                                                  else
                                                    return null;
                                                }
                                              },
                                              onChanged: (input) {
                                                setState(() {
                                                  catergory = input;
                                                });
                                              },
                                              keyboardType: TextInputType.text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top:6 * SizeConfig.heightMultiplier),
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Container(

                                        child: new Center(
                                            child: new TextFormField(
                                                decoration: new InputDecoration(
                                                  labelText: "Catergory Searchkey",
                                                  prefixIcon: Icon(Icons.youtube_searched_for,
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

                                                  ),
                                                  enabledBorder:
                                                  OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(0xFF185a9d),
                                                        style: BorderStyle.solid,
                                                        width: 1),

                                                  ),

                                                ),

                                                validator: (input) => input
                                                    .isEmpty
                                                    ? 'Please type your catergory search key here'
                                                    : null,
                                                onChanged: (input) {
                                                  setState(() {
                                                    catergorysearchkey = input;
                                                  });
                                                },
                                                keyboardType: TextInputType.text,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1)),
                                      ),
                                    ),
                                  ),


                                  // button
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 7 * SizeConfig.heightMultiplier,
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
                                                await _categoryService
                                                    .createCatData(catergory,catergorysearchkey);

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
                                                              "Catergory is added",
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
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ProductCollection()));
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


                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                const Color(0xFF185a9d),
                                                const Color(0xFF43cea2)
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
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
