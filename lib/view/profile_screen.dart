import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/components/listtile_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/image_const.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:sizer/sizer.dart';

import '../get_storage_services/get_storage_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> accountOptions = [
    {
      'icon': ImageConst.personel,
      'title': 'Personal Information',
    },
    {
      'icon': ImageConst.payments,
      'title': 'Payments and payouts',
    },
    {
      'icon': ImageConst.notification2,
      'title': 'Notifications',
    },
    {
      'icon': ImageConst.language,
      'title': 'Language',
    },
    {
      'icon': ImageConst.privacy,
      'title': 'Privacy and sharing',
    },
  ];
  List<Map<String, dynamic>> supportOptions = [
    {
      'icon': ImageConst.aboutUs,
      'title': 'How Inzoid works',
    },
    {
      'icon': ImageConst.safety,
      'title': 'Safety Center',
    },
    {
      'icon': ImageConst.support,
      'title': 'Support',
    },
    {
      'icon': ImageConst.getHelp,
      'title': 'Get Help',
    },
  ];
  List<Map<String, dynamic>> legalOptions = [
    {
      'icon': ImageConst.terms,
      'title': 'Term of Service',
    },
    {
      'icon': ImageConst.feedback,
      'title': 'Give us Feedback',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                accountSettings(),
                support(),
                legal(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column legal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 3.h,
        ),
        CommonText.textBoldWight600(text: "Legal", fontSize: 18.sp),
        SizedBox(
          height: 1.h,
        ),
        Column(
          children: List.generate(
            legalOptions.length,
            (index) => ListTileWidget(
              onTap: () {
                if (GetStorageServices.getUserLoggedInStatus() != true) {
                  Get.to(() => SignInScreen());
                }
              },
              icon: legalOptions[index]['icon'],
              title: legalOptions[index]['title'],
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }

  Column support() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 3.h,
        ),
        CommonText.textBoldWight600(text: "Support", fontSize: 18.sp),
        SizedBox(
          height: 1.h,
        ),
        Column(
          children: List.generate(
            supportOptions.length,
            (index) => ListTileWidget(
              onTap: () {
                if (GetStorageServices.getUserLoggedInStatus() != true) {
                  Get.to(() => SignInScreen());
                }
              },
              icon: supportOptions[index]['icon'],
              title: supportOptions[index]['title'],
            ),
          ),
        )
      ],
    );
  }

  Column accountSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.textBoldWight600(text: "Account Settings", fontSize: 18.sp),
        SizedBox(
          height: 1.h,
        ),
        Column(
          children: List.generate(
            accountOptions.length,
            (index) => ListTileWidget(
              onTap: () {
                if (GetStorageServices.getUserLoggedInStatus() != true) {
                  Get.to(() => SignInScreen());
                }
              },
              icon: accountOptions[index]['icon'],
              title: accountOptions[index]['title'],
            ),
          ),
        )
      ],
    );
  }

  Column header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 3.h,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 30.sp,
              backgroundImage: AssetImage(ImageConst.user),
            ),
            SizedBox(
              width: 4.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.textBoldWight600(
                    text: "Naman Sharma", fontSize: 18.sp),
                SizedBox(
                  height: 3.sp,
                ),
                CommonText.textBoldWight500(
                    textDecoration: TextDecoration.underline,
                    text: "View Profile",
                    fontSize: 12.sp,
                    color: themColors309D9D),
              ],
            )
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Divider(
          thickness: 1,
          color: Color(0xffECECEC),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}