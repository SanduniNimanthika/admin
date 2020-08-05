import 'package:admin/database/Catdatabase.dart';
import 'package:admin/StoreDisplay/catergorylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/commanpages/configue.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/module/catergory.dart';
import 'package:admin/module/subcar.dart';
import 'package:admin/database/subcatdatabse.dart';


class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {


  @override
  Widget build(BuildContext context) {
    return     StreamProvider<List<Catergory>>.value(
    value: CatergoryService().catergory,
    child:   StreamProvider<List<SubCatergory>>.value(
        value: SubCatergoryService().subcatergory,
        child: StoreHomes()));

  }

  }






