import 'package:get/get.dart';

class FilterScreenController extends GetxController {
  bool isSwitch = false;
  setIsSwitch(bool value) {
    isSwitch = value;
    update();
  }

  int indexOfSize = 0;
  setIndexOfSize(int index) {
    indexOfSize = index;
    update();
  }

  int indexOfSeason = 0;
  setIndexOfSeason(int index) {
    indexOfSeason = index;
    update();
  }

  int indexOfColor = 0;
  setIndexOfColor(int index) {
    indexOfColor = index;
    update();
  }

  int indexOfMaterialColor = 0;
  setIndexOfMaterialColor(int index) {
    indexOfMaterialColor = index;
    update();
  }

  double rangeOfSlider = 0;
  double rangeOfSlider1 = 100;
  setRangeOfSlider(double value) {
    rangeOfSlider = value;
    update();
  }

  setRangeOfSlider1(double value) {
    rangeOfSlider1 = value;
    update();
  }
}
