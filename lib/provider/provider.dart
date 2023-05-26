

import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier{

 static int selectVideo=1;
  changeSelect(index){
    selectVideo=index;
    notifyListeners();
  }

 int selectScreen=0;
 changeScreen(index){
   selectScreen=index;
   notifyListeners();
 }

 bool mini = false;

 miniPlayer(){
   mini=!mini;
   notifyListeners();
 }

 bool isFull=false;
double  minHeight= 70;
double  maxHeight= 370;

 fullVideo(){
   if( isFull)
   minHeight= 70;
   maxHeight= 370;
   isFull=!isFull;
   notifyListeners();
 }

}