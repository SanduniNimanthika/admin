import 'package:admin/AddItem/product.dart';
import 'package:admin/commanpages/commanWidgets.dart';
import 'package:admin/database/Catdatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/notifer/catergorynotifer.dart';
import 'package:admin/module/catergory.dart';
import 'package:provider/provider.dart';
import 'package:admin/StoreDisplay/subcatergorylist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCat extends StatefulWidget {
  final String text;

  AddCat({
    Key key,
    @required this.text,
  }) : super(key: key);
  @override
  _AddCatState createState() => _AddCatState(text: text);
}

class _AddCatState extends State<AddCat> {
  Catergory _currentCatergory;
  final String text;

  _AddCatState({
    Key key,
    @required this.text,
  });
  bool loading = false;
  String catergory = '';

  CatergoryService _categoryService = CatergoryService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context, listen: false);

    if (catergoryNotifier.currentCatergory != null) {
      _currentCatergory = catergoryNotifier.currentCatergory;
    } else {
      _currentCatergory = Catergory();
    }
  }

  _onCatergoryUploaded(Catergory catergory) {
    CatergoryNotifier catergoryNotifier =
        Provider.of<CatergoryNotifier>(context, listen: false);
    catergoryNotifier.addCatergory(catergory);
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
                          decoration: BoxDecoration(
                            gradient: linearcolor(),
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
                              if (text == "AddItem") {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Item()));
                              } else {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubCatergorylist()));
                              }
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
                                              initialValue: (text == "AddItem")
                                                  ? null
                                                  : _currentCatergory.catergory,
                                              decoration: inputDecaration(
                                                  context,
                                                  "Catergory Name",
                                                  Icons.add),
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
                                                  if (text == "AddItem") {
                                                    catergory = input;
                                                  } else {
                                                    _currentCatergory
                                                        .catergory = input;
                                                  }
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
                                      top: 7 * SizeConfig.heightMultiplier,
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      elevation: 4.0,
                                      child: InkWell(
                                        onTap: () async {
                                          if (text == "AddItem") {
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() {
                                                loading = true;
                                              });
                                              await _categoryService
                                                  .createCatData(catergory);

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Container(
                                                        height: 150.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          20.0),
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
                                                                  EdgeInsets
                                                                      .all(
                                                                          30.0),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                                elevation: 4.0,
                                                                child: InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => Item()));
                                                                    },
                                                                    child: buttonContainer(
                                                                        context,
                                                                        "okay",
                                                                        40.0,
                                                                        100.0)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            }
                                          } else {
                                            saveEdit();
                                            Firestore.instance
                                                .collection('SubCatergory')
                                                .where("catergorykey",
                                                    isEqualTo: _currentCatergory
                                                        .catkey)
                                                .getDocuments()
                                                .then((querySnapshot) {
                                              querySnapshot.documents
                                                  .forEach((result) {
                                                String id = result.data['uid'];
                                                Firestore.instance
                                                    .collection('SubCatergory')
                                                    .document(id)
                                                    .updateData({
                                                  'catergory': _currentCatergory
                                                      .catergory
                                                });
                                              });
                                            });
                                            Firestore.instance
                                                .collection('Product')
                                                .where("catergorykey",
                                                    isEqualTo: _currentCatergory
                                                        .catkey)
                                                .getDocuments()
                                                .then((querySnapshot) {
                                              querySnapshot.documents
                                                  .forEach((result) {
                                                String id = result.data['uid'];
                                                Firestore.instance
                                                    .collection('Product')
                                                    .document(id)
                                                    .updateData({
                                                  'catergory': _currentCatergory
                                                      .catergory
                                                });
                                              });
                                            });
                                          }
                                        },
                                        child: buttonContainerWithBlue(
                                            context, "Save", 40, null),
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

  saveEdit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    uploadCatergory(
        _currentCatergory /*widget.isUpdating*/, _onCatergoryUploaded);
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
                      "Catergory is updated",
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
                                    builder: (context) => SubCatergorylist()));
                          },
                          child: buttonContainer(context, "okay", 40, 100)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
