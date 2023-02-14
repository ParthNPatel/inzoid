import 'package:get/get.dart';
import 'package:inzoid/get_storage_services/get_storage_service.dart';

class FilterScreenController extends GetxController {
  bool isSwitch = false;
  setIsSwitch(bool value) {
    isSwitch = value;
    update();
  }

  int indexOfSize = 0;
  String? sizeName;
  // String indexOfSize = 0;
  setIndexOfSize(int index, String name) {
    indexOfSize = index;
    sizeName = name;
    update();
  }

  int indexOfSeason = 0;
  String? seasonName;
  setIndexOfSeason(int index, String name) {
    indexOfSeason = index;
    if (name.isNotEmpty) {
      seasonName = name;
    }
    update();
  }

  int indexOfColor = 0;
  String? colorName;
  setIndexOfColor(int index, String name) {
    indexOfColor = index;
    colorName = name;
    print('--colorName---${colorName}');
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
  double rangeOfSlider1 = 10000;

  int? startPrice = 0;
  int? endPrice = 10000;
  setRangeOfSlider(double value) {
    rangeOfSlider = value;
    startPrice = int.parse(rangeOfSlider.toStringAsFixed(0));
    GetStorageServices.setStart(startPrice!);
    print('-------rangeOfSlider1----$startPrice');
    update();
  }

  setRangeOfSlider1(double value) {
    rangeOfSlider1 = value;
    endPrice = int.parse(rangeOfSlider1.toStringAsFixed(0));
    GetStorageServices.setEnd(endPrice!);

    print('-------rangeOfSlider----$endPrice');

    update();
  }
}
