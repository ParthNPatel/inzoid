import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/get_storage_services/get_storage_service.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:sizer/sizer.dart';

import '../constant/color_const.dart';
import '../constant/text_styel.dart';
import '../view/product_detail_screen.dart';
import 'favourite_button.dart';

class ProductTile extends StatelessWidget {
  final image;
  final title;
  final subtitle;
  final price;
  final oldPrice;
  final rating;
  final onTap;

  const ProductTile(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.oldPrice,
      required this.rating,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: Stack(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 145.sp,
                  width: 130.sp,
                  decoration: BoxDecoration(
                    color: CommonColor.greyColorF2F2F2,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                top: 8.sp,
                right: 8.sp,
                child: FavouriteButton(),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        CommonText.textBoldWight700(text: title, fontSize: 10.sp),
        SizedBox(
          height: 2.sp,
        ),
        CommonText.textBoldWight400(
            text: subtitle, fontSize: 8.sp, color: CommonColor.greyColor838589),
        SizedBox(
          height: 5.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText.textBoldWight700(text: price, fontSize: 10.sp),
            SizedBox(
              width: 2.w,
            ),
            CommonText.textBoldWight700(
                color: CommonColor.greyColorD9D9D9,
                textDecoration: TextDecoration.lineThrough,
                text: oldPrice,
                fontSize: 10.sp),
          ],
        ),
        SizedBox(
          height: 5.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              5,
              (index) => Icon(
                    Icons.star,
                    size: 11.sp,
                    color: CommonColor.yellowColor,
                  )),
        ),
        SizedBox(
          height: 5.sp,
        ),
        CommonText.textBoldWight400(
            text: rating, fontSize: 6.sp, color: CommonColor.greyColor838589),
      ],
    );
  }
}
