import 'dart:collection';
import 'package:admin/module/catergory.dart';
import 'package:flutter/cupertino.dart';

class CatergoryNotifier with ChangeNotifier {
  List<Catergory> _catergoryList = [];
  Catergory _currentCatergory;



  UnmodifiableListView<Catergory> get catergoryList => UnmodifiableListView(_catergoryList);

  Catergory get currentCatergory => _currentCatergory;

  set catergoryList(List<Catergory> catergorylist) {
    _catergoryList = catergorylist;
    notifyListeners();
  }

  set currentCatergory(Catergory catergory) {
    _currentCatergory = catergory;
    notifyListeners();
  }

  addCatergory(Catergory catergory) {
    _catergoryList.insert(0, catergory);
    notifyListeners();
 }

  deleteCatergory(Catergory catergory) {
    _catergoryList.removeWhere((_catergory) => _catergory.catkey == catergory.catkey);
    notifyListeners();
  }
}