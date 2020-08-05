import 'package:admin/product/addsubcat.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin/product/serachbar.dart';


class SearchCatergory extends StatefulWidget {
  @override
  _SearchCatergoryState createState() => new _SearchCatergoryState();
}

class _SearchCatergoryState extends State<SearchCatergory> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          setState(() {
            tempSearchStore.add(queryResultSet[i]);});
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        queryResultSet.forEach((element) {
          if (element['catergory'].toLowerCase().contains(value.toLowerCase()) ==  true) {
            if (element['catergory'].toLowerCase().indexOf(value.toLowerCase()) ==0) {
              setState(() {
                tempSearchStore.add(element);
              });
            }
          }

        });

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(

          body: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (val) {
                  initiateSearch(val);
                },
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 20.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Search by Caterogry name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0))),
              ),
            ),
            SizedBox(height: 20.0),
            ListView(
              shrinkWrap: true,
                children: tempSearchStore.map((element) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSubCat(text:element['catergory'])));
                    },
                    child:Padding(
                      padding: const EdgeInsets.only(top:15.0),
                      child: ListTile(
                        title: Text(element['catergory'],style: Theme.of(context).textTheme.display1,
                      ),
                      ),
                    )
                  );
                }).toList()),


          ])),
    );
  }
}

