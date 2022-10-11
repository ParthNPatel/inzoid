import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/view/sign_up_screen.dart';
import 'package:inzoid/view/update_passwoed_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        title: 'Inzoid',
        home: UpdatePasswordScreen(),
      ),
    );
  }
}
