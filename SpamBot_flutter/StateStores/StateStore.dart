import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Prediction with ChangeNotifier {
  String _userText = '';
  String _prediction = 'Start typing..';
  double _confidence = 0.0;

  String get userText => _userText;
  String get prediction => _prediction;
  double get confidence => _confidence;

  set userText(String newText) {
    _userText = newText;
    notifyListeners();
  }

  set prediction(String newText) {
    _prediction = newText;
    notifyListeners();
  }

  set confidence(double newValue) {
    _confidence = newValue;
    notifyListeners();
  }
}
