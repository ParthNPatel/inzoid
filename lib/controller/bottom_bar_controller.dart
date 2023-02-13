import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  int pageSelected = 0;

  void updatePage(int value) {
    pageSelected = value;
    update();
  }
}
