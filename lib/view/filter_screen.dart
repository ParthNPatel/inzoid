import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/view/category_screen.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';
import '../constant/const_size.dart';
import '../constant/text_styel.dart';
import '../controller/filter_screen_controller.dart';

class FilterScreen extends StatefulWidget {
  final categories;
  const FilterScreen({Key? key, this.categories}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterScreenController _filterScreenController = Get.find();

  List<String> sizeList = ['XS', 'S', 'M', 'L', 'XL'];
  List<String> seasonList = ['Summer', 'Autumn', 'Winter', 'Spring'];
  List<String> materialList = ['Viscose', 'Cotton', 'Cotton', 'Linen'];

  List<String> colorList = [
    '0xffDCDCDC',
    '0xffFBFFC8',
    '0xffFFFFFF',
    '0xffE7E7FF',
    '0xff934232',
    '0xff444B73',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(() => CategoryScreen(
              category: '${widget.categories}',
            ));
        return false;
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: GetBuilder<FilterScreenController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CommonSize.screenPadding),
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
                        values: RangeValues(controller.rangeOfSlider,
                            controller.rangeOfSlider1),
                        min: 0.0,
                        max: 10000.0,
                        // label: '${controller.rangeOfSlider.round()}',
                        onChanged: (value) {
                          controller.setRangeOfSlider(value.start);
                          controller.setRangeOfSlider1(value.end);
                        },
                      ),
                    ),
                    CommonWidget.commonSizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CommonSize.screenPadding),
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
                            children:
                                List.generate(materialList.length, (index) {
                              return Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setIndexOfMaterialColor(
                                        index, materialList[index]);
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    alignment: Alignment.center,
                                    height: 40.sp,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          new BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        color: CommonColor.greyColorf2f4f5),
                                    child: CommonText.textBoldWight400(
                                      text: materialList[index],
                                      color: controller.indexOfMaterialColor ==
                                              index
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
                      padding: EdgeInsets.symmetric(
                          horizontal: CommonSize.screenPadding),
                      child: CommonWidget.commonButton(
                          onTap: () {
                            Get.off(() => CategoryScreen(
                                  category: '${widget.categories}',
                                ));
                          },
                          text: 'Show items'),
                    ),
                    CommonWidget.commonSizedBox(height: 50),
                  ]),
            );
          },
        ),
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
                    controller.setIndexOfColor(index, colorList[index]);
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
                        color: Color(int.parse(colorList[index]))),
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
                    controller.setIndexOfSize(index, sizeList[index]);
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
            _filterScreenController.startPrice = 0;
            _filterScreenController.endPrice = 10000;
            _filterScreenController.rangeOfSlider = 0;
            _filterScreenController.rangeOfSlider1 = 10000;
            _filterScreenController.sizeName = null;
            _filterScreenController.indexOfSize = 0;
            _filterScreenController.seasonName = null;
            _filterScreenController.indexOfSeason = 0;
            _filterScreenController.colorName = null;
            _filterScreenController.indexOfColor = 0;
            _filterScreenController.materialName = null;
            _filterScreenController.indexOfMaterialColor = 0;
            Get.back();
            setState(() {});
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
              GestureDetector(
                onTap: () {
                  _filterScreenController.startPrice = 0;
                  _filterScreenController.endPrice = 10000;
                  _filterScreenController.rangeOfSlider = 0;
                  _filterScreenController.rangeOfSlider1 = 10000;
                  _filterScreenController.sizeName = null;
                  _filterScreenController.indexOfSize = 0;
                  _filterScreenController.seasonName = null;
                  _filterScreenController.indexOfSeason = 0;
                  _filterScreenController.colorName = null;
                  _filterScreenController.indexOfColor = 0;
                  _filterScreenController.materialName = null;
                  _filterScreenController.indexOfMaterialColor = 0;
                  Get.back();
                  setState(() {});
                },
                child: CommonText.textBoldWight500(
                    text: TextConst.reset, color: CommonColor.themColor309D9D),
              ),
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
