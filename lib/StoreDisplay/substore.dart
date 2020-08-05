import 'package:admin/StoreDisplay/subcatergorylist.dart';
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


class SubStore extends StatefulWidget {
  @override
  _SubStoreState createState() => _SubStoreState();
}

class _SubStoreState extends State<SubStore> {


  @override
  Widget build(BuildContext context) {
    return    StreamProvider<List<SubCatergory>>.value(
            value: SubCatergoryService().subcatergory,
            child: SubCatergorylist());

  }

}


