import 'package:get/get.dart';

class FilterScreenController extends GetxController {
  bool isSwitch = false;
  setIsSwitch(bool value) {
    isSwitch = value;
    update();
  }

  int indexOfSize = 0;
  // String indexOfSize = 0;
  setIndexOfSize(int index) {
    indexOfSize = index;
    update();
  }

  int indexOfSeason = 0;
  String? season;
  setIndexOfSeason(int index, String name) {
    indexOfSeason = index;
    if (name.isNotEmpty) {
      season = name;
    }
    update();
  }

  int indexOfColor = 0;
  setIndexOfColor(int index) {
    indexOfColor = index;
    update();
  }

  int indexOfMaterialColor = 0;
  String? materialName;
  setIndexOfMaterialColor(int index, String name) {
    indexOfMaterialColor = index;
    if (name.isNotEmpty) {
      materialName = name;
    }

    print('------$name');
    update();
  }

  double rangeOfSlider = 0;
  double rangeOfSlider1 = 100;
  setRangeOfSlider(double value) {
    rangeOfSlider = value;
    print('-------rangeOfSlider----$rangeOfSlider');
    update();
  }

  setRangeOfSlider1(double value) {
    rangeOfSlider1 = value;
    update();
  }
}
