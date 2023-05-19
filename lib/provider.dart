

import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier{

 static int selectVideo=1;
  changeSelect(index){
    selectVideo=index;
    notifyListeners();
  }
}