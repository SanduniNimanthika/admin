
import 'package:admin/database/subcatdatabse.dart';
import 'package:admin/AddItem/searchcat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/AddItem/productcollection.dart';


class AddSubCat extends StatefulWidget {
  final String text;
  final String text2;

  AddSubCat({Key key, @required this.text, @required this.text2} ):super(key:key);

  @override
  _AddSubCatState createState() => _AddSubCatState(text: text,text2: text2);
}



class _AddSubCatState extends State<AddSubCat> {
  bool loading = false;
  String subcatergory = '';
  String error = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SubCatergoryService _subcategoryService = SubCatergoryService();

  String _currentCatergory;
  String subcatergorysearchkey='';
  String catergorykey;


  final String text;
  final String text2;
  _AddSubCatState({Key key, @required this.text, @required this.text2});


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
                    child: Column(
                      children: <Widget>[
                        Form(
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
                                Padding(
                                  padding:  EdgeInsets.only(top:3*SizeConfig.heightMultiplier),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex:6,
                                        child: Opacity(
                                          opacity: 0.8,
                                          child: Material(
                                            color: Colors.white,
                                            child: Container(
                                              height: 53,

                                              decoration: BoxDecoration(

                                                  border: Border.all(
                                                      color: Color(0xFF185a9d)
                                                  )
                                              ),
                                              child: Padding(
                                                padding:  EdgeInsets.only(left:10.0),
                                                child: Center(child: Row(
                                                  children: <Widget>[
                                                    Expanded(child: Text(text==null?'Search Catergory':text,style: Theme.of(context).textTheme.display1,)),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Opacity(
                                            opacity: 0.8,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: Container(
                                                      height: 53,
                                                      //   width: 40,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xFF185a9d),
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: IconButton(icon: Icon(Icons.check,color: Colors.white,),
                                                        onPressed: (){
                                                          setState(() {
                                                            _currentCatergory=text;
                                                            catergorykey=text2;
                                                            print(text);
                                                            print(catergorykey);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(

                                                      height: 53,
                                                      //     width: 40,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blueGrey,
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),

                                                      child: InkWell(
                                                          onTap: (){
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        SearchCatergory()));
                                                          },
                                                          child: Icon(Icons.search))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(error,style:Theme.of(context).textTheme.display1.copyWith(color: Colors.red,fontSize: 12.0)),



                                Opacity(
                                  opacity: 0.8,
                                  child: Padding(
                                    padding: EdgeInsets.only(top:6 * SizeConfig.heightMultiplier,bottom: 6* SizeConfig.heightMultiplier),
                                    child: Container(
                                      child: new Center(
                                          child: new TextFormField(
                                              decoration: new InputDecoration(
                                                labelText: "SubCatergory Name",
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
                                                  return 'Please provide a subcatergory name';
                                                } else {
                                                  if (!regex.hasMatch(input))
                                                    return 'You subcatergory name should be begin with capital letter';
                                                  else
                                                    return null;
                                                }
                                              },
                                              onChanged: (input) {
                                                setState(() {
                                                  subcatergory = input;
                                                });
                                              },
                                              keyboardType: TextInputType.text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1)),
                                    ),
                                  ),
                                ),


                                Opacity(
                                  opacity: 0.8,
                                  child: Container(

                                    child: new Center(
                                        child: new TextFormField(
                                            decoration: new InputDecoration(
                                              labelText: "SubCatergory Searchkey",
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
                                                ? 'Please type your subcatergory search key here'
                                                : null,
                                            onChanged: (input) {
                                              setState(() {
                                                subcatergorysearchkey = input;
                                                catergorykey=text2;
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1)),
                                  ),
                                ),


                                // button
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10 * SizeConfig.heightMultiplier,
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
                                          if(_currentCatergory!=null){
                                          await _subcategoryService
                                              .createSubCatData(subcatergory,_currentCatergory,subcatergorysearchkey,catergorykey);

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
                                                            "Subcatergory is added",
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
                                        else{
                                        setState(() {
                                          error =
                                          "please supply a catergory name\n and click blue botton";
                                          loading = false;
                                        });}
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
                      ],
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

