import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/filter_screen.dart';
import 'package:inzoid/view/product_detail_screen.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../components/category_shimmer.dart';
import '../components/product_tile.dart';
import '../constant/image_const.dart';
import '../get_storage_services/get_storage_service.dart';

class CategoryScreen extends StatefulWidget {
  final category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // List<Map<String, dynamic>> categories = [
  //   {'image': ImageConst.shirts, 'title': "Shirts"},
  //   {'image': ImageConst.dress, 'title': "Dress"},
  //   {'image': ImageConst.suit, 'title': "Suit"},
  //   {'image': ImageConst.jeans, 'title': "Jeans"},
  // ];

  List<String> subCategories = [
    'All',
    'Shirt',
    'Jeans',
    'Outer Desss',
  ];

  int categorySelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: CommonText.textBoldWight700(
            text: widget.category, color: Colors.black),
        actions: [
          CommonWidget.commonSvgPitcher(
              image: ImageConst.search, height: 18.sp, width: 18.sp),
          SizedBox(
            width: CommonSize.screenPadding,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            filterOption(),
            brandNewCollection(),
            Container(
              height: 250.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        ImageConst.banner2,
                      ),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: SizedBox(
                height: 30.sp,
                child: ListView.builder(
                  itemCount: subCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        categorySelected = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 30.sp,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: categorySelected == index
                            ? Colors.black
                            : CommonColor.greyColorD9D9D9,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: CommonText.textBoldWight400(
                          text: subCategories[index],
                          color: categorySelected == index
                              ? Colors.white
                              : CommonColor.greyColor838589,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc('all_product')
                  .collection('product_data')
                  .where('category', isEqualTo: '${widget.category}')
                  .orderBy('create_time', descending: true)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length != 0) {
                    return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.sp / 3.7.sp,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          var data = snapshot.data.docs[index];
                          return ProductTile(
                            onTap: () {
                              if (GetStorageServices.getUserLoggedInStatus() ==
                                  true) {
                                Get.to(() => ProductDetailScreen(
                                      productData: snapshot.data.docs[index],
                                    ));
                              } else {
                                Get.to(() => SignInScreen());
                              }
                            },
                            image: data['listOfImage'][0],
                            title: data['productName'],
                            subtitle: data['brand'],
                            price: data['price'],
                            oldPrice: data['oldPrice'],
                            rating: '(200 Ratings)',
                            productID: int.parse(data['productId']),
                          );
                        });
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        CommonText.textBoldWight600(
                            text: "No Product found of ${widget.category}")
                      ],
                    );
                  }
                } else {
                  return CategoryProductShimmer();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Container brandNewCollection() {
    return Container(
      color: blueColor,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Admin')
                .doc('sub_categories')
                .collection('sub_category_list')
                .where('category_name', isEqualTo: widget.category)
                .get(),
            builder: (BuildContext context, AsyncSnapshot data) {
              if (data.hasData) {
                var categories = data.data.docs;
                return SizedBox(
                  height: 90.sp,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        categories.length,
                        (index) => Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 70.sp,
                              width: 60.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  height: 65.sp,
                                  width: 60.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(categories[index]
                                            ['sub_category_image'][0]),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.sp,
                            ),
                            CommonText.textBoldWight400(
                              text: categories[index]['sub_category_name'],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return CategoryShimmer();
              }
            },
          ),
        ],
      ),
    );
  }

  Container filterOption() {
    return Container(
      height: 50.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => FilterScreen());
            },
            child: Row(
              children: [
                CommonWidget.commonSvgPitcher(
                    image: ImageConst.filter, height: 15.sp, width: 15.sp),
                SizedBox(
                  width: 3.w,
                ),
                CommonText.textBoldWight400(
                    text: "Filter",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),
          VerticalDivider(),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                CommonWidget.commonSvgPitcher(
                    image: ImageConst.tune, height: 15.sp, width: 15.sp),
                SizedBox(
                  width: 3.w,
                ),
                CommonText.textBoldWight400(
                    text: "Popular",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
