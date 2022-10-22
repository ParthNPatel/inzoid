import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant/color_const.dart';
import 'common_widget.dart';

class ListTileWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const ListTileWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          minVerticalPadding: 0,
          onTap: onTap,
          leading: Container(
            height: 25.sp,
            width: 25.sp,
            decoration: BoxDecoration(
              color: blueColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: CommonWidget.commonSvgPitcher(
                image: icon,
                height: 15.sp,
                width: 15.sp,
              ),
            ),
          ),
          title: Text(title),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: themColors309D9D,
          ),
        ),
        Divider(
          height: 5,
          thickness: 1,
          color: Color(0xffECECEC),
        ),
      ],
    );
  }
}
