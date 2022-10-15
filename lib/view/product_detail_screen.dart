import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';
import '../components/product_tile.dart';
import '../constant/color_const.dart';
import '../constant/const_size.dart';
import '../constant/image_const.dart';
import '../constant/text_const.dart';
import '../constant/text_styel.dart';
import '../controller/filter_screen_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final categoryName;

  const ProductDetailScreen({super.key, required this.categoryName});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int currentPage = 0;

  List colors = [
    Color(0xff3C302E),
    Color(0xffF3F1EF),
    Color(0xffD2A916),
  ];

  int colorSelected = 0;
  List<String> sizeList = ['XS', 'S', 'M', 'L', 'XL'];

  List<Map<String, dynamic>> data = [
    {
      'image': ImageConst.women3,
      'title': 'CLAUDETTE CORSET',
      'subtitle': 'TMP Company',
      'price': '₹999,00',
      'oldPrice': '₹1299,00',
      'rating': '(200 Ratings)'
    },
    {
      'image': ImageConst.women4,
      'title': ' Tailored FULL Skirta',
      'subtitle': 'TMP Company',
      'price': '₹999,00',
      'oldPrice': '₹1299,00',
      'rating': '(200 Ratings)'
    },
    {
      'image': ImageConst.women5,
      'title': 'CLAUDETTE CORSET',
      'subtitle': 'TMP Company',
      'price': '₹999,00',
      'oldPrice': '₹1299,00',
      'rating': '(200 Ratings)'
    },
    {
      'image': ImageConst.women6,
      'title': ' Tailored FULL Skirta',
      'subtitle': 'TMP Company',
      'price': '₹999,00',
      'oldPrice': '₹1299,00',
      'rating': '(200 Ratings)'
    },
  ];

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
            text: widget.categoryName, color: Colors.black),
        actions: [
          InkResponse(
            onTap: () {},
            child: SvgPicture.asset(
              ImageConst.share,
              height: 38.sp,
              width: 30.sp,
            ),
          ),
          SizedBox(width: 7)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 60.h,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        height: 60.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/detail.png'),
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                    onPageChanged: (val) {
                      setState(() {
                        currentPage = val;
                      });
                    },
                    itemCount: 5,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: buildDots(currentPage, 5),
                )
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  CommonText.textBoldWight700(
                      text: "CLAUDETTE CORSET SHIRT DRESS IN WHITE",
                      fontSize: 11.sp),
                  SizedBox(
                    height: 3.sp,
                  ),
                  CommonText.textBoldWight400(
                      text: "TMP Company",
                      fontSize: 10.sp,
                      color: CommonColor.greyColor838589),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      size: 19.sp,
                                      color: CommonColor.yellowColor,
                                    )),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          CommonText.textBoldWight400(
                              text: "(200 Ratings)",
                              fontSize: 6.sp,
                              color: CommonColor.greyColor838589),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonText.textBoldWight700(
                              text: "₹999,00", fontSize: 12.sp),
                          SizedBox(
                            width: 2.w,
                          ),
                          CommonText.textBoldWight700(
                              color: CommonColor.greyColorD9D9D9,
                              textDecoration: TextDecoration.lineThrough,
                              text: "₹1299,00",
                              fontSize: 12.sp),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              thickness: 1,
              color: Color(0xffF2F4F5),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textBoldWight700(text: "Color", fontSize: 15.sp),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              colorSelected = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: 20.sp,
                            backgroundColor: colors[index],
                            child: Icon(
                              Icons.check,
                              size: 20.sp,
                              color: colorSelected == index
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  widgetOfSize(),
                  SizedBox(
                    height: 5.sp,
                  ),
                  CommonText.textBoldWight700(
                      color: CommonColor.greyColorD9D9D9,
                      text: "Size guide",
                      fontSize: 11.sp),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.textBoldWight700(
                          text: "Description", fontSize: 15.sp),
                      SvgPicture.asset(
                        ImageConst.arrowUp,
                        height: 8.sp,
                        width: 8.sp,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text:
                          "A Shirt Is A profitable Investment In The Wardrobe. And here's why:",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 7.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text: " - shirts perfectly match with any bottom",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 7.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text:
                          "  - shirts made of natural fabrics are suitable for any time of the year.",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 20.sp,
                  ),
                  CommonText.textBoldWight700(
                      text: "Similar Products", fontSize: 15.sp),
                  SizedBox(
                    height: 15.sp,
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.sp / 3.8.sp,
                        crossAxisSpacing: 15),
                    itemBuilder: (context, index) => ProductTile(
                      image: data[index]['image'],
                      title: data[index]['title'],
                      subtitle: data[index]['subtitle'],
                      price: data[index]['price'],
                      oldPrice: data[index]['oldPrice'],
                      rating: data[index]['rating'],
                    ),
                  ),
                ],
              ),
            ),
            CommonWidget.commonSizedBox(height: 14),
            Center(
              child: CommonText.textBoldWight500(
                  text: 'Did you like the Product?',
                  color: Colors.black,
                  fontSize: 18.sp),
            ),
            CommonWidget.commonSizedBox(height: 14),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
              child:
                  CommonWidget.commonButton(onTap: () {}, text: 'Contact Us'),
            ),
            CommonWidget.commonSizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget widgetOfSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.textBoldWight500(
            text: TextConst.size, color: Colors.black, fontSize: 18.sp),
        CommonWidget.commonSizedBox(height: 10),
        Row(
          children: List.generate(sizeList.length, (index) {
            return Padding(
              padding: EdgeInsets.all(8.sp),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 35.sp,
                  width: 35.sp,
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
                    color: CommonColor.blackColor000000,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildDots(int currentPage, int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < totalPages; i++)
          Container(
            width: i == currentPage ? 25 : 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: i == currentPage ? Colors.white : const Color(0xff979C9E),
            ),
          ),
      ],
    );
  }
}
