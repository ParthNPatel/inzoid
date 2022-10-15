import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/view/bottom_bar_screen.dart';
import 'package:inzoid/view/category_screen.dart';
import 'package:inzoid/view/filter_screen.dart';
import 'package:inzoid/view/home_screen.dart';
import 'package:inzoid/view/product_detail_screen.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:inzoid/view/sign_up_screen.dart';

import 'package:sizer/sizer.dart';

import 'controller/filter_screen_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: BaseBindings(),
        title: 'Inzoid',
        theme: ThemeData(fontFamily: TextConst.fontFamily),
        home: BottomNavScreen(),
      ),
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterScreenController(), fenix: true);
  }
}
