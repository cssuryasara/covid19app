import 'package:flutter/foundation.dart';

class Scrollevent with ChangeNotifier {
  bool _isscrooling;
  // bool _isEnabled;
  Scrollevent(this._isscrooling);
  get getscrooling => _isscrooling;
  // get getdirection => _isEnabled;
  set setscrolling(bool status) {
    _isscrooling = status;
    notifyListeners();
  }
}