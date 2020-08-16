
import 'package:admin/StoreDisplay/productlist.dart';
import 'package:admin/StoreDisplay/seracheditcatergory.dart';
import 'package:admin/database/subcatdatabse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:admin/commanpages/loading.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/StoreDisplay/subcatergorynotifier.dart';
import 'package:admin/module/subcar.dart';
import 'package:provider/provider.dart';


class EditSubCatergory extends StatefulWidget {
  final String text;

  EditSubCatergory({Key key,@required this.text}):super(key:key);

  @override
  _EditSubCatergoryState createState() => _EditSubCatergoryState(text: text);
}



class _EditSubCatergoryState extends State<EditSubCatergory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SubCatergory _currentSubCatergory;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    SubCatergoryNotifier subcatergoryNotifier = Provider.of<SubCatergoryNotifier>(
        context, listen: false);

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
  final String text;
  _EditSubCatergoryState({Key key,@required this.text});


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
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Productlist()));
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
                                                            _currentSubCatergory.catergory=text;
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
                                                                        SearchEditCatergory()));
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




                                Opacity(
                                  opacity: 0.8,
                                  child: Padding(
                                    padding: EdgeInsets.only(top:6 * SizeConfig.heightMultiplier,bottom: 6* SizeConfig.heightMultiplier),
                                    child: Container(
                                      child: new Center(
                                          child: new TextFormField(
                                            initialValue: _currentSubCatergory.subcatergory,
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
                                                  _currentSubCatergory.subcatergory = input;
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
                                          initialValue: _currentSubCatergory.subcatergorysearchkey,
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
                                                _currentSubCatergory.subcatergorysearchkey = input;
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
                                        saveEdit();


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

  saveEdit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    uploadSubCatergory(
        _currentSubCatergory /*widget.isUpdating*/,
        _onSubCatergoryUploaded
    );
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
                        child: Container(
                          height: 40.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF185a9d),
                                const Color(0xFF43cea2)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text("okay",
                                style: Theme.of(context).textTheme.subhead),
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
}

