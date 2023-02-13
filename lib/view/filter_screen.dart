import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:sizer/sizer.dart';

import '../components/common_widget.dart';
import '../constant/const_size.dart';
import '../constant/text_styel.dart';
import '../controller/filter_screen_controller.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterScreenController _filterScreenController = Get.find();

  List<String> sizeList = ['XS', 'S', 'M', 'L', 'XL'];
  List<String> seasonList = ['Summer', 'Autumn', 'Winter', 'Spring'];
  List<String> materialList = ['Viscose', 'Cotton', 'Cotton', 'Linen'];

  List<Color> colorList = [
    Color(0xffDCDCDC),
    Color(0xffFBFFC8),
    Color(0xffFFFFFF),
    Color(0xffE7E7FF),
    Color(0xff934232),
    Color(0xff444B73),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GetBuilder<FilterScreenController>(
        builder: (controller) {
          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonSizedBox(height: 8),
                    CommonText.textBoldWight500(
                        text: TextConst.price,
                        color: CommonColor.blackColor000000,
                        fontSize: 18.sp),
                    CommonWidget.commonSizedBox(height: 10),
                    Row(
                      children: [
                        sliderValue(
                            sliderValue: controller.rangeOfSlider,
                            formBy: TextConst.from),
                        CommonWidget.commonSizedBox(width: 8),
                        sliderValue(
                            sliderValue: controller.rangeOfSlider1,
                            formBy: TextConst.by),
                      ],
                    ),
                  ],
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 2.5,
                    activeTrackColor: themColors309D9D,
                    inactiveTrackColor: CommonColor.borderColorE3E5E6,
                    thumbColor: themColors309D9D),
                child: RangeSlider(
                  values: RangeValues(
                      controller.rangeOfSlider, controller.rangeOfSlider1),
                  min: 0.0,
                  max: 100.0,
                  // label: '${controller.rangeOfSlider.round()}',
                  onChanged: (value) {
                    controller.setRangeOfSlider(value.start);
                    controller.setRangeOfSlider1(value.end);
                  },
                ),
              ),
              CommonWidget.commonSizedBox(height: 20),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.textBoldWight500(
                          text: TextConst.itemsOnSale,
                          color: Colors.black,
                          fontSize: 18.sp),
                      CupertinoSwitch(
                        value: controller.isSwitch,
                        activeColor: themColors309D9D,
                        onChanged: (value) {
                          controller.setIsSwitch(value);
                        },
                      )
                    ]),
              ),
              CommonWidget.commonSizedBox(height: 20),
              widgetOfSize(controller),
              CommonWidget.commonSizedBox(height: 20),
              widgetOfSeason(controller),
              CommonWidget.commonSizedBox(height: 10),
              widgetOfColor(controller),
              CommonWidget.commonSizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: CommonText.textBoldWight500(
                            text: TextConst.material,
                            color: Colors.black,
                            fontSize: 18.sp)),
                    CommonWidget.commonSizedBox(height: 14),
                    Row(
                      children: List.generate(materialList.length, (index) {
                        return Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: GestureDetector(
                            onTap: () {
                              controller.setIndexOfMaterialColor(
                                  index, materialList[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              alignment: Alignment.center,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  color: CommonColor.greyColorf2f4f5),
                              child: CommonText.textBoldWight400(
                                text: materialList[index],
                                color: controller.indexOfMaterialColor == index
                                    ? CommonColor.blackColor000000
                                    : CommonColor.greyColor00003,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              CommonWidget.commonSizedBox(height: 20),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
                child: CommonWidget.commonButton(
                    onTap: () {
                      Get.back();

                      setState(() {});
                    },
                    text: 'Show 248 items'),
              ),
              CommonWidget.commonSizedBox(height: 50),
            ]),
          );
        },
      ),
    );
  }

  Padding widgetOfColor(FilterScreenController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CommonText.textBoldWight500(
                  text: TextConst.color, color: Colors.black, fontSize: 18.sp)),
          CommonWidget.commonSizedBox(height: 14),
          Row(
            children: List.generate(colorList.length, (index) {
              return Padding(
                padding: EdgeInsets.all(3.sp),
                child: GestureDetector(
                  onTap: () {
                    controller.setIndexOfColor(index);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5,
                            color: controller.indexOfColor == index
                                ? CommonColor.themColor309D9D
                                : Colors.transparent),
                        shape: BoxShape.circle,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1.0,
                          ),
                        ],
                        color: colorList[index]),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Padding widgetOfSeason(FilterScreenController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CommonText.textBoldWight500(
                  text: TextConst.season,
                  color: Colors.black,
                  fontSize: 18.sp)),
          CommonWidget.commonSizedBox(height: 14),
          Row(
            children: List.generate(seasonList.length, (index) {
              return Padding(
                padding: EdgeInsets.all(8.sp),
                child: GestureDetector(
                  onTap: () {
                    controller.setIndexOfSeason(index, seasonList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    height: 40.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1.0,
                          ),
                        ],
                        color: CommonColor.greyColorf2f4f5),
                    child: CommonText.textBoldWight400(
                      text: seasonList[index],
                      color: controller.indexOfSeason == index
                          ? CommonColor.blackColor000000
                          : CommonColor.greyColor00003,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Padding widgetOfSize(FilterScreenController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CommonText.textBoldWight500(
                  text: TextConst.size, color: Colors.black, fontSize: 18.sp)),
          CommonWidget.commonSizedBox(height: 14),
          Row(
            children: List.generate(sizeList.length, (index) {
              return Padding(
                padding: EdgeInsets.all(8.sp),
                child: GestureDetector(
                  onTap: () {
                    controller.setIndexOfSize(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 1.0,
                          ),
                        ],
                        color: CommonColor.greyColorf2f4f5),
                    child: CommonText.textBoldWight400(
                      text: sizeList[index],
                      color: controller.indexOfSize == index
                          ? CommonColor.blackColor000000
                          : CommonColor.greyColor00003,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.7,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18.sp,
            color: Colors.black,
          ),
        ),
      ),
      centerTitle: true,
      title: CommonText.textBoldWight500(
          text: TextConst.filters, color: Colors.black),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              CommonText.textBoldWight500(
                  text: TextConst.reset, color: CommonColor.themColor309D9D),
            ],
          ),
        )
      ],
    );
  }

  Expanded sliderValue({double? sliderValue, required String formBy}) {
    return Expanded(
      child: Material(
        child: Container(
          height: 40.sp,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: CommonColor.borderColorE3E5E6),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 1.0,
                ),
              ],
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.textBoldWight400(
                    text: formBy,
                    color: CommonColor.blackColor000000,
                  ),
                  CommonText.textBoldWight500(
                    text: '₹${sliderValue!.toInt()}',
                    color: CommonColor.blackColor000000,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
