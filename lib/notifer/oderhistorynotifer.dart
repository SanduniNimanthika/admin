import 'dart:collection';

import 'package:admin/module/oderhistory.dart';
import 'package:flutter/cupertino.dart';


class ProductOrderHistoryNotifier with ChangeNotifier {
  List<ProductOrderHistory> _productOrderHistoryList = [];

  ProductOrderHistory _currentProductOrderHistory;




  UnmodifiableListView<ProductOrderHistory> get productOrderHistoryList => UnmodifiableListView(_productOrderHistoryList);

  ProductOrderHistory get currentProductOrderHistory => _currentProductOrderHistory;

  set productOrderHistoryList(List<ProductOrderHistory> productOrderHistorylist) {
    _productOrderHistoryList = productOrderHistorylist;
    notifyListeners();
  }

  set currentProductOrderHistory(ProductOrderHistory productOrderHistory) {
    _currentProductOrderHistory = productOrderHistory;
    notifyListeners();
  }


  addProductOrderHistory(ProductOrderHistory productOrderHistory) {
    _productOrderHistoryList.insert(0, productOrderHistory);
    notifyListeners();
  }


}