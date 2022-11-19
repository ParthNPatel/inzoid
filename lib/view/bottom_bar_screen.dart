import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/image_const.dart';
import 'package:inzoid/view/home_screen.dart';
import 'package:inzoid/view/profile_screen.dart';
import 'package:inzoid/view/sign_in_screen.dart';

import '../get_storage_services/get_storage_service.dart';
import '../services/app_notification.dart';
import 'my_wish_list_page.dart';
import 'notification_sacreen.dart';

class BottomNavScreen extends StatefulWidget {
  int? index;

  BottomNavScreen({super.key, this.index = 0});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  List<Map<String, dynamic>> bottomItems = [
    {'icon': ImageConst.home, 'label': 'Home'},
    {'icon': ImageConst.notification1, 'label': 'Notification'},
    {'icon': ImageConst.favourite, 'label': 'Favourite'},
    {'icon': ImageConst.profile, 'label': 'Profile'},
  ];

  int pageSelected = 0;

  List<Widget> screens = [
    HomeScreen(),
    Center(child: Text("Notifications")),
    MyWishListPage(),
    ProfileScreen()
  ];
  @override
  void initState() {
    pageSelected = widget.index!;
    AppNotificationHandler.getInitialMsg();
    AppNotificationHandler.showMsgHandler();
    AppNotificationHandler.onMsgOpen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageSelected == 0
          ? HomeScreen()
          : pageSelected == 1
              ? NotificationScreen()
              : pageSelected == 2
                  ? MyWishListPage()
                  : ProfileScreen(),
      // if (pageSelected == 0) HomeScreen(),
      // if (pageSelected == 1) Center(child: Text("Notifications")),
      // if (pageSelected == 2) Center(child: Text("Favourite")),
      // if (pageSelected == 3) Center(child: Text("Profile")),
      bottomNavigationBar: Container(
        //height: 100,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              bottomItems.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (GetStorageServices.getUserLoggedInStatus() == true ||
                        index == 0) {
                      pageSelected = index;
                      setState(() {});
                    } else {
                      Get.to(() => SignInScreen());
                    }
                  },
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          bottomItems[index]['icon'],
                          color: pageSelected == index
                              ? themColors309D9D
                              : Color(0xffCFCFCF),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          bottomItems[index]['label'],
                          style: TextStyle(
                              color: pageSelected == index
                                  ? Colors.black
                                  : Color(0xffCFCFCF)),
                        )
                      ]),
                ),
              ),
            )),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   currentIndex: pageSelected,
      //   onTap: (value) {
      //     setState(() {
      //       pageSelected = value;
      //     });
      //   },
      //   selectedItemColor: themColors309D9D,
      //   unselectedItemColor: Color(0xffCFCFCF),
      //   type: BottomNavigationBarType.fixed,
      //   items: List.generate(
      //     bottomItems.length,
      //     (index) => BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         bottomItems[index]['icon'],
      //         color:
      //             pageSelected == index ? themColors309D9D : Color(0xffCFCFCF),
      //       ),
      //       label: bottomItems[index]['label'],
      //     ),
      //   ),
      // ),
    );
  }
}
