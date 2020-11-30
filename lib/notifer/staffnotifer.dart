import 'dart:collection';
import 'package:admin/module/staff.dart';
import 'package:flutter/cupertino.dart';

class StaffNotifier with ChangeNotifier {
  List<Staff> _staffList = [];
  Staff _currentStaff;



  UnmodifiableListView<Staff> get staffList => UnmodifiableListView(_staffList);

  Staff get currentStaff => _currentStaff;

  set staffList(List<Staff> stafflist) {
    _staffList = stafflist;
    notifyListeners();
  }

  set currentStaff(Staff staff) {
    _currentStaff = staff;
    notifyListeners();
  }


}