import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/controller/filter_screen_controller.dart';
import 'package:inzoid/view/filter_screen.dart';
import 'package:inzoid/view/product_detail_screen.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:inzoid/view/web_view.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? demoData = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? dummyData = [];
  int categorySelected = 0;

  int pageSelected = 0;
  FilterScreenController controller = Get.put(FilterScreenController());
  @override
  Widget build(BuildContext context) {
    print('---widget.category}----${widget.category}');
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
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc('banners')
                  .collection('banner_list')
                  .where('category', isEqualTo: widget.category)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250.sp,
                          child: PageView.builder(
                              itemCount: snapshot.data.docs.length,
                              onPageChanged: (value) {
                                setState(() {
                                  pageSelected = value;
                                });
                              },
                              itemBuilder: (context, index) {
                                var banners = snapshot.data.docs[index];
                                return InkWell(
                                  onTap: () {
                                    // https://www.youtube.com/results?search_query=tv+app+controll+to+remort+in+flutter+
                                    Get.to(
                                      () => WebViewScreen(
                                        link: '${banners['link']}',
                                      ),
                                    );
                                  },
                                  child: Container(
                                    //height: 150.sp,
                                    // width: 100.sp,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              banners['banner_image'][0]),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        snapshot.data.docs.length < 2
                            ? SizedBox()
                            : AnimatedSmoothIndicator(
                                activeIndex: pageSelected,
                                count: snapshot.data.docs.length,
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
                  );
                } else {
                  return BannerShimmer();
                }
              },
            ),
            // Container(
            //   height: 250.sp,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage(
            //           ImageConst.banner2,
            //         ),
            //         fit: BoxFit.cover),
            //   ),
            // ),
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
                  // .orderBy('create_time', descending: true)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length != 0) {
                    return GetBuilder<FilterScreenController>(
                      builder: (filterScreenController) {
                        print(
                            '----filterScreenController.materialName==${filterScreenController.materialName}');
                        print(
                            '----filterScreenController.seasonName--${filterScreenController.seasonName}');
                        print(
                            '----filterScreenController.sizeName---${filterScreenController.sizeName}');
                        print(
                            '----filterScreenController.colorName---${filterScreenController.colorName}');
                        filterScreenController.startPrice =
                            GetStorageServices.getStart();
                        filterScreenController.endPrice =
                            GetStorageServices.getEnd();
                        print(
                            '----startPrice${filterScreenController.startPrice}');
                        print('----endPrice${filterScreenController.endPrice}');
                        return MasonryGridView.count(
                          // mainAxisSpacing: 20,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            if (filterScreenController.startPrice == 0 &&
                                filterScreenController.endPrice == 10000 &&
                                filterScreenController.colorName == null) {
                              print('------0000');
                              return buildProductTile(snapshot, index, data);
                            } else if (data['price'] >
                                    filterScreenController.startPrice &&
                                data['price'] <
                                    filterScreenController.endPrice &&
                                (data['color'] as List).contains(
                                    filterScreenController.colorName)) {
                              print('------111');

                              return buildProductTile(snapshot, index, data);
                            } else if (data['price'] >
                                    filterScreenController.startPrice &&
                                data['price'] <
                                    filterScreenController.endPrice &&
                                filterScreenController.colorName == null) {
                              print('------2222');

                              return buildProductTile(snapshot, index, data);
                            } else if (filterScreenController.startPrice == 0 &&
                                filterScreenController.endPrice == 10000 &&
                                (data['color'] as List).contains(
                                    filterScreenController.colorName)) {
                              print('------3333');

                              return buildProductTile(snapshot, index, data);
                            } else {
                              print('------4444');

                              return SizedBox();
                            }
                          },
                          crossAxisCount: 2,
                        );
                      },
                    );
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

  ProductTile buildProductTile(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      int index,
      QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return ProductTile(
      needBottomMargin: true,
      onTap: () {
        print('----ID${data['productId']}');

        if (GetStorageServices.getUserLoggedInStatus() == true) {
          Get.to(() => ProductDetailScreen(
                productData: snapshot.data!.docs[index],
              ));
        } else {
          Get.to(() => SignInScreen());
        }
      },
      image: data['listOfImage'][0],
      title: data['productName'],
      stock: data['quantity'],
      subtitle: data['brand'],
      price: data['price'],
      oldPrice: data['oldPrice'],
      rating: '(200 Ratings)',
      productID: int.parse(data['productId']),
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
              Get.off(() => FilterScreen(
                    categories: widget.category,
                  ));
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
