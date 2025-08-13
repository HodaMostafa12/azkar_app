import 'package:flutter/material.dart';


class SebhaViewModel extends ChangeNotifier {
  SebhaModel _model = SebhaModel();

  int get count => _model.count;

  void increment() {
    _model.count++;
    notifyListeners();
  }

  void reset() {
    _model.count = 0;
    notifyListeners();
  }
}


/////////////Model/////////////

class SebhaModel {
  int count;

  SebhaModel({this.count = 0});
}


