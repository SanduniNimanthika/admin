import 'package:admin/AddItem/product.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/database/subcatdatabse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:admin/database/Catdatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/StoreDisplay/productlist.dart';
import 'package:admin/notifer/subcatergorynotifier.dart';
import 'package:admin/module/subcar.dart';
import 'package:provider/provider.dart';

class AddSubCat extends StatefulWidget {
  final String text;

  AddSubCat({
    Key key,
    @required this.text,
  }) : super(key: key);
  @override
  _AddSubCatState createState() => _AddSubCatState(text: text);
}

class _AddSubCatState extends State<AddSubCat> {
  bool loading = false;
  String subcatergory = '';
  String error = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SubCatergoryService _subcategoryService = SubCatergoryService();
  CatergoryService catergoryService = CatergoryService();

  String _currentCatergory;

  String catergorykey;
  final String text;

  _AddSubCatState({
    Key key,
    @required this.text,
  });
  SubCatergory _currentSubCatergory;
  @override
  void initState() {
    super.initState();
    SubCatergoryNotifier subcatergoryNotifier =
        Provider.of<SubCatergoryNotifier>(context, listen: false);

    if (subcatergoryNotifier.currentSubCatergory != null) {
      _currentSubCatergory = subcatergoryNotifier.currentSubCatergory;
    } else {
      _currentSubCatergory = SubCatergory();
    }
  }

  _onSubCatergoryUploaded(SubCatergory subcatergory) {
    SubCatergoryNotifier subcatergoryNotifier =
        Provider.of<SubCatergoryNotifier>(context, listen: false);
    subcatergoryNotifier.addSubCatergory(subcatergory);
  }

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
                          decoration: BoxDecoration(gradient: linearcolor()),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (text == "AddItem") {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Item()));
                              } else {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Productlist()));
                              }
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 12 *
                                                SizeConfig.heightMultiplier,
                                            bottom: 3 *
                                                SizeConfig.heightMultiplier),
                                        child: Opacity(
                                          opacity: .8,
                                          child: TypeAheadField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              autofocus: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              decoration: InputDecoration(
                                                labelText: (text == "AddItem")
                                                    ? (_currentCatergory ==
                                                            null)
                                                        ? "search by catertgory name"
                                                        : _currentCatergory
                                                    : _currentSubCatergory
                                                        .catergory,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .display1,
                                                prefixIcon: Icon(Icons.search,
                                                    color: Colors.blueGrey),
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
                                            ),
                                            suggestionsCallback:
                                                (pattern) async {
                                              return await catergoryService
                                                  .getSuggestions(pattern);
                                            },
                                            itemBuilder: (context, suggestion) {
                                              return Column(
                                                children: <Widget>[
                                                  ListTile(
                                                    leading:
                                                        Icon(Icons.category),
                                                    title: Text(
                                                      suggestion['catergory'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .display1,
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Colors.grey,
                                                  )
                                                ],
                                              );
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              if (text == "AddItem") {
                                                setState(() {
                                                  _currentCatergory =
                                                      suggestion['catergory'];

                                                  catergorykey =
                                                      suggestion['uid'];
                                                  print(
                                                      suggestion['catergory']);
                                                });
                                              } else {
                                                setState(() {
                                                  _currentSubCatergory
                                                          .catergory =
                                                      suggestion['catergory'];

                                                  _currentSubCatergory
                                                          .catergorykey =
                                                      suggestion['uid'];
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Text(error,
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .copyWith(
                                                  color: Colors.red,
                                                  fontSize: 12.0)),

                                      Opacity(
                                        opacity: 0.8,
                                        child: Container(
                                          child: new Center(
                                              child: new TextFormField(
                                                  initialValue:
                                                      (text == "AddItem")
                                                          ? null
                                                          : _currentSubCatergory
                                                              .subcatergory,
                                                  decoration:inputDecaration(context, "SubCatergory Name", Icons.add,),

                                                  validator: (input) {
                                                    Pattern pattern =
                                                        r'^(?=.*?[A-Z])(?=.*?[a-z]).{2,}$';
                                                    RegExp regex =
                                                        new RegExp(pattern);
                                                    if (input.isEmpty) {
                                                      return 'Please provide a subcatergory name';
                                                    } else {
                                                      if (!regex
                                                          .hasMatch(input))
                                                        return 'You subcatergory name should be begin with capital letter';
                                                      else
                                                        return null;
                                                    }
                                                  },
                                                  onChanged: (input) {
                                                    setState(() {
                                                      if (text == "AddItem") {
                                                        subcatergory = input;
                                                      } else {
                                                        setState(() {
                                                          _currentSubCatergory
                                                              .subcatergory =
                                                              input;
                                                        });

                                                      }
                                                    });
                                                  },
                                                  keyboardType:
                                                      TextInputType.text,
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          elevation: 4.0,
                                          child: InkWell(
                                              onTap: () async {
                                                if (text != 'Updating') {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    if (_currentCatergory !=
                                                        null) {
                                                      await _subcategoryService
                                                          .createSubCatData(
                                                              subcatergory,
                                                              _currentCatergory,
                                                              catergorykey);

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
                                                                        "Subcatergory is added",
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
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Item()));
                                                                            },
                                                                            child: buttonContainer(context, "okay", 43.0, 100.0)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      setState(() {
                                                        error =
                                                            "please supply a catergory name";
                                                        loading = false;
                                                      });
                                                    }
                                                  }
                                                } else {
                                                  saveEdit();
                                                  Firestore.instance
                                                      .collection('Product')
                                                      .where("subcatergorykey",
                                                          isEqualTo:
                                                              _currentSubCatergory
                                                                  .subcatkey)
                                                      .getDocuments()
                                                      .then((querySnapshot) {
                                                    querySnapshot.documents
                                                        .forEach((result) {
                                                      String id =
                                                          result.data['uid'];
                                                      Firestore.instance
                                                          .collection('Product')
                                                          .document(id)
                                                          .updateData({
                                                        'subcatergory':
                                                            _currentSubCatergory
                                                                .subcatergory
                                                      });
                                                    });
                                                  });
                                                }
                                              },
                                              child:buttonContainerWithBlue(context, "Save", 40, null)
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

  saveEdit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    uploadSubCatergory(_currentSubCatergory, _onSubCatergoryUploaded);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 150.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Subcatergory is updated",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 4.0,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(20.0),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Productlist()));
                          },
                          child: buttonContainer(context, 'okey', 43.0, 100.0)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
