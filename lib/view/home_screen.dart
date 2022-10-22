import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/view/category_screen.dart';
import 'package:inzoid/view/product_detail_screen.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/favourite_button.dart';
import '../components/product_tile.dart';
import '../constant/const_size.dart';
import '../constant/image_const.dart';
import '../constant/text_styel.dart';
import 'package:get/get.dart';

import '../get_storage_services/get_storage_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Map<String, dynamic>> categories = [
  //   {'image': ImageConst.deal, 'title': "Deal"},
  //   {'image': ImageConst.men, 'title': "Men"},
  //   {'image': ImageConst.women, 'title': "Women"},
  //   {'image': ImageConst.kids, 'title': "Kids"},
  //   {'image': ImageConst.sportsWear, 'title': "Sport Wear"},
  // ];

  List<Map<String, dynamic>> categories = [
    {'image': ImageConst.deal2, 'title': "Deal"},
    {'image': ImageConst.men2, 'title': "Men"},
    {'image': ImageConst.women2, 'title': "Women"},
    {'image': ImageConst.kids2, 'title': "Kids"},
    {'image': ImageConst.sportsWear2, 'title': "Sport Wear"},
  ];

  List<Map<String, dynamic>> brandManiaList = [
    {'image': ImageConst.jiniJony, 'logo': ImageConst.jiniJonyLogo},
    {'image': ImageConst.hm, 'logo': ImageConst.hmLogo},
    {'image': ImageConst.gucci, 'logo': ImageConst.gucciLogo},
  ];

  int pageSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: blueColor,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          categories.length,
                          (index) => Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => CategoryScreen(
                                      category: categories[index]['title'],
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 55.sp,
                                  width: 45.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: Center(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      height: 50.sp,
                                      width: 48.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(7),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                categories[index]['image']),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.sp,
                              ),
                              CommonText.textBoldWight400(
                                text: categories[index]['title'],
                              ),
                            ],
                          ),
                        ),
                      )),
                  //categoriesWidget(),
                  bannerWidget(),
                  brandMania(),
                ],
              ),
            ),
            mensProduct(),
            womenProduct(),
            kidsProduct(),
          ],
        ),
      ),
    );
  }

  Padding kidsProduct() {
    return Padding(
      padding: EdgeInsets.only(left: CommonSize.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: CommonSize.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.textBoldWight400(
                    text: TextConst.men,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                InkWell(
                  onTap: () {
                    if (GetStorageServices.getUserLoggedInStatus() == true) {
                      Get.to(() => CategoryScreen(
                            category: "Men",
                          ));
                    } else {
                      Get.to(() => SignInScreen());
                    }
                  },
                  child: CommonText.textBoldWight400(
                      color: themColors309D9D,
                      text: TextConst.seeAll,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          SizedBox(
            height: 230.sp,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc('all_product')
                  .collection('product_data')
                  .where('category', isEqualTo: 'Kids')
                  .orderBy('create_time', descending: true)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var fetchMenData = snapshot.data.docs![index];
                      print('material  ${fetchMenData['material']}');
                      return ProductTile(
                        image: fetchMenData['listOfImage'][0],
                        title: fetchMenData['productName'],
                        subtitle: fetchMenData['brand'],
                        price: fetchMenData['price'],
                        oldPrice: fetchMenData['oldPrice'],
                        rating: "(200 Ratings)",
                        onTap: () {
                          if (GetStorageServices.getUserLoggedInStatus() ==
                              true) {
                            Get.to(() => ProductDetailScreen(
                                  productData: fetchMenData,
                                ));
                          } else {
                            Get.to(() => SignInScreen());
                          }
                        },
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding womenProduct() {
    return Padding(
      padding: EdgeInsets.only(left: CommonSize.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: CommonSize.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.textBoldWight400(
                    text: TextConst.men,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                InkWell(
                  onTap: () {
                    if (GetStorageServices.getUserLoggedInStatus() == true) {
                      Get.to(() => CategoryScreen(
                            category: "Men",
                          ));
                    } else {
                      Get.to(() => SignInScreen());
                    }
                  },
                  child: CommonText.textBoldWight400(
                      color: themColors309D9D,
                      text: TextConst.seeAll,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          SizedBox(
            height: 230.sp,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc('all_product')
                  .collection('product_data')
                  .where('category', isEqualTo: 'Women')
                  .orderBy('create_time', descending: true)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var fetchMenData = snapshot.data.docs![index];
                      print('material  ${fetchMenData['material']}');
                      return ProductTile(
                          image: fetchMenData['listOfImage'][0],
                          title: fetchMenData['productName'],
                          subtitle: fetchMenData['brand'],
                          price: fetchMenData['price'],
                          oldPrice: fetchMenData['oldPrice'],
                          rating: "(200 Ratings)",
                          onTap: () {
                            if (GetStorageServices.getUserLoggedInStatus() ==
                                true) {
                              Get.to(() => ProductDetailScreen(
                                    productData: fetchMenData,
                                  ));
                            } else {
                              Get.to(() => SignInScreen());
                            }
                          });
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget mensProduct() {
    return Padding(
      padding: EdgeInsets.only(left: CommonSize.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: CommonSize.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.textBoldWight400(
                    text: TextConst.men,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                InkWell(
                  onTap: () {
                    if (GetStorageServices.getUserLoggedInStatus() == true) {
                      Get.to(() => CategoryScreen(
                            category: "Men",
                          ));
                    } else {
                      Get.to(() => SignInScreen());
                    }
                  },
                  child: CommonText.textBoldWight400(
                      color: themColors309D9D,
                      text: TextConst.seeAll,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          SizedBox(
            height: 230.sp,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc('all_product')
                  .collection('product_data')
                  .where('category', isEqualTo: 'Men')
                  .orderBy('create_time', descending: true)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var fetchMenData = snapshot.data.docs![index];
                      print('material  ${fetchMenData['material']}');
                      return ProductTile(
                          image: fetchMenData['listOfImage'][0],
                          title: fetchMenData['productName'],
                          subtitle: fetchMenData['brand'],
                          price: fetchMenData['price'],
                          oldPrice: fetchMenData['oldPrice'],
                          rating: "(200 Ratings)",
                          onTap: () {
                            if (GetStorageServices.getUserLoggedInStatus() ==
                                true) {
                              Get.to(() => ProductDetailScreen(
                                    productData: fetchMenData,
                                  ));
                            } else {
                              Get.to(() => SignInScreen());
                            }
                          });
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding brandMania() {
    return Padding(
      padding: EdgeInsets.only(left: CommonSize.screenPadding),
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: CommonSize.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.textBoldWight400(
                    text: TextConst.brandMania,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                InkWell(
                  onTap: () {},
                  child: CommonText.textBoldWight400(
                      color: themColors309D9D,
                      text: TextConst.seeAll,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          SizedBox(
            height: 100.sp,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(right: 4.w),
                height: 100.sp,
                width: 120.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(brandManiaList[index]['image']),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 30.sp,
                        width: 120.sp,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(bottom: Radius.circular(9)),
                        ),
                        child: Center(
                          child: Image.asset(
                            brandManiaList[index]['logo'],
                            height: 15.sp,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }

  Container bannerWidget() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: CommonSize.screenPadding, top: 10),
        child: Column(
          children: [
            SizedBox(
              height: 140.sp,
              child: PageView.builder(
                  itemCount: 3,
                  onPageChanged: (value) {
                    setState(() {
                      pageSelected = value;
                    });
                  },
                  itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(right: 6.w),
                        //height: 150.sp,
                        // width: 100.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(ImageConst.banner),
                              fit: BoxFit.cover),
                        ),
                      )),
            ),
            SizedBox(
              height: 3.h,
            ),
            AnimatedSmoothIndicator(
              activeIndex: pageSelected,
              count: 3,
              effect: WormEffect(
                  spacing: 4,
                  dotWidth: 7.0,
                  dotHeight: 7.0,
                  dotColor: CommonColor.greyColorD9D9D9,
                  activeDotColor: themColors309D9D),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(
            //       3,
            //       (index) => Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 3),
            //             child: GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   pageSelected = index;
            //                 });
            //               },
            //               child: CircleAvatar(
            //                 radius: 3.5,
            //                 backgroundColor: pageSelected == index
            //                     ? themColors309D9D
            //                     : CommonColor.greyColorD9D9D9,
            //               ),
            //             ),
            //           )),
            // ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    );
  }

  Padding categoriesWidget() {
    return Padding(
      padding: EdgeInsets.only(left: CommonSize.screenPadding, top: 30),
      child: Container(
        color: blueColor,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 25, bottom: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    categories.length,
                    (index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => CategoryScreen(
                                category: categories[index]['title'],
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: 55.sp,
                            width: 45.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                height: 50.sp,
                                width: 48.sp,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          categories[index]['image']),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        CommonText.textBoldWight400(
                          text: categories[index]['title'],
                        ),
                      ],
                    ),
                  ),
                )),
            //categoriesWidget(),
            bannerWidget(),
            brandMania(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.7,
      shadowColor: Colors.grey.shade100,
      leadingWidth: 100.sp,
      leading: Row(
        children: [
          SizedBox(
            width: CommonSize.screenPadding,
          ),
          Text(
            TextConst.inzoid,
            style: TextStyle(
                color: themColors309D9D,
                fontWeight: FontWeight.w600,
                fontSize: 19.sp),
          ),
        ],
      ),
      actions: [
        InkResponse(
          onTap: () {},
          child: CommonWidget.commonSvgPitcher(
              image: ImageConst.bell, height: 18.sp, width: 18.sp),
        ),
        SizedBox(
          width: CommonSize.screenPadding,
        ),
        InkResponse(
          onTap: () {},
          child: CommonWidget.commonSvgPitcher(
              image: ImageConst.search, height: 18.sp, width: 18.sp),
        ),
        SizedBox(
          width: CommonSize.screenPadding,
        ),
      ],
    );
  }
}
