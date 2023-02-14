import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../components/common_widget.dart';
import '../components/product_tile.dart';
import '../constant/color_const.dart';
import '../constant/const_size.dart';
import '../constant/image_const.dart';
import '../constant/text_const.dart';
import '../constant/text_styel.dart';
import '../get_storage_services/get_storage_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final productData;
  final bool? isDecoded;

  const ProductDetailScreen(
      {super.key, this.productData, this.isDecoded = false});

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

  bool isContainCheck = false;

  bool isDone = false;
  double rating = 0;

  /// WhatsApp Share:

  void launchWhatsapp() {
    launch(WhatsAppUnilink(
      phoneNumber: "919999713112",
      text: "Hello Admin, Wanted to inquire about the product",
    ).toString());
  }

  TextEditingController description = TextEditingController();

  @override
  void initState() {
    isDone = widget.isDecoded!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("DATA++>>${widget.productData}");
    // log('Run Type==>${jsonDecode(widget.productData['listOfImage']).length > 1}');
    log('Run Type11111==>$isDone');
    log('Run Type==>${widget.isDecoded == true ? jsonDecode(widget.productData['listOfImage']).length > 1 : widget.productData['listOfImage'].length > 1}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.7,
        leading: bacButtonWidget(),
        centerTitle: true,
        title: CommonText.textBoldWight700(
            text: widget.productData['category'], color: Colors.black),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  try {
                    print('like not goo  ${widget.productData['productId']}');
                    isContainCheck = snapshot.data['list_of_like']
                        .contains(int.parse(widget.productData['productId']));
                    print(
                        'list_of_like  ${snapshot.data['list_of_like'].contains(widget.productData['productId'])}');
                  } catch (e) {
                    isContainCheck = false;
                  }

                  return GestureDetector(
                    onTap: () {
                      likeUnLike(
                          productId:
                              int.parse(widget.productData['productId']));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      height: 30,
                      width: 30,
                      child: Center(
                        child: likeWidget(snapshot),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    height: 30,
                    width: 30,
                  );
                }
              },
              future: FirebaseFirestore.instance
                  .collection('All_User_Details')
                  .doc(GetStorageServices.getToken())
                  .get(),
            ),
          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: contactUsButton(),
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
                              image: NetworkImage(
                                  '${isDone == true ? jsonDecode(widget.productData['listOfImage'])[index] : widget.productData['listOfImage'][index]}'),
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                    onPageChanged: (val) {
                      setState(() {
                        currentPage = val;
                      });
                    },
                    itemCount: isDone == true
                        ? jsonDecode(widget.productData['listOfImage']).length
                        : widget.productData['listOfImage'].length,
                  ),
                ),
                isDone == false
                    ? Positioned(
                        left: 0,
                        right: 0,
                        bottom: 20,
                        child: widget.productData['listOfImage'].length > 1
                            ? buildDots(
                                currentPage,
                                widget.productData['listOfImage'].length,
                              )
                            : SizedBox(),
                      )
                    : Positioned(
                        left: 0,
                        right: 0,
                        bottom: 20,
                        child: jsonDecode(widget.productData['listOfImage'])
                                    .length >
                                1
                            ? buildDots(
                                currentPage,
                                jsonDecode(widget.productData['listOfImage'])
                                    .length,
                              )
                            : SizedBox(),
                      ),
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
                      text: "${widget.productData['productName']}",
                      fontSize: 11.sp),
                  SizedBox(
                    height: 3.sp,
                  ),
                  CommonText.textBoldWight400(
                      text: "${widget.productData['brand']}",
                      fontSize: 10.sp,
                      color: CommonColor.greyColor838589),
                  SizedBox(
                    height: 2.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText.textBoldWight700(
                          text: "₹${widget.productData['price']}",
                          fontSize: 12.sp),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageConst.piecs,
                            height: 10.sp,
                            width: 10.sp,
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          CommonText.textBoldWight700(
                              text:
                                  '${widget.productData['quantity']} PIECES IN STOCK',
                              fontSize: 8.sp,
                              color: CommonColor.greyColor838589),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonText.textBoldWight700(
                          text: "Product Details", fontSize: 15.sp),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text: "${widget.productData['description']}",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 15.sp,
                  ),
                  CommonText.textBoldWight700(
                      text: "Size & Fit", fontSize: 15.sp),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text: "The model (height 6') is wearing a size M",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 15.sp,
                  ),
                  CommonText.textBoldWight700(
                      text: "Material & Care", fontSize: 15.sp),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text: "Material: 60% cotton, 40% polyesterMachine Wash",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 15.sp,
                  ),
                  CommonText.textBoldWight700(
                      text: "Specifications", fontSize: 15.sp),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text:
                          "Specifications: Long Sleeves\nNeck: Round Neck\nPattern: Colourblocked\nLength: Regular\nType: Pullover\nPrint or Pattern Type: Colourblocked\nOccasion: Casual\nHemline: Straight",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 15.sp,
                  ),
                  CommonText.textBoldWight700(
                      text: "Rating & Reviews", fontSize: 15.sp),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CommonText.textBoldWight500(
                      color: CommonColor.greyColor838589,
                      text: "Summary",
                      fontSize: 12.sp),
                  SizedBox(
                    height: 10.sp,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ProductRating')
                        .doc(widget.productData['productId'])
                        .collection('Rating')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        double everageRating1 = 0;
                        List star1 = [];
                        List star2 = [];
                        List star3 = [];
                        List star4 = [];
                        List star5 = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          everageRating1 += int.parse(snapshot
                              .data!.docs[i]['rating']
                              .toString()
                              .split('.')
                              .first);
                          if (snapshot.data!.docs[i]['rating'] == 1) {
                            star1.add(int.parse(snapshot.data!.docs[i]['rating']
                                .toString()
                                .split('.')
                                .first));
                          }
                          if (snapshot.data!.docs[i]['rating'] == 2) {
                            star2.add(int.parse(snapshot.data!.docs[i]['rating']
                                .toString()
                                .split('.')
                                .first));
                          }
                          if (snapshot.data!.docs[i]['rating'] == 3) {
                            star3.add(int.parse(snapshot.data!.docs[i]['rating']
                                .toString()
                                .split('.')
                                .first));
                          }
                          if (snapshot.data!.docs[i]['rating'] == 4) {
                            star4.add(int.parse(snapshot.data!.docs[i]['rating']
                                .toString()
                                .split('.')
                                .first));
                          }
                          if (snapshot.data!.docs[i]['rating'] == 5) {
                            star5.add(int.parse(snapshot.data!.docs[i]['rating']
                                .toString()
                                .split('.')
                                .first));
                          }
                        }
                        everageRating1 =
                            everageRating1 / snapshot.data!.docs.length;
                        var everageRating = everageRating1.toStringAsFixed(1);
                        print(
                            '----everageRating---${(star5.length / snapshot.data!.docs.length).runtimeType}');
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CommonText.textBoldWight500(
                                              color:
                                                  CommonColor.greyColor838589,
                                              text: "5",
                                              fontSize: 12.sp),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              child: LinearProgressIndicator(
                                                color: Color(0xffFFB400),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                value: star5.length == 0
                                                    ? 0.0
                                                    : star5.length /
                                                        snapshot
                                                            .data!.docs.length,
                                                minHeight: 8.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Row(
                                        children: [
                                          CommonText.textBoldWight500(
                                              color:
                                                  CommonColor.greyColor838589,
                                              text: "4",
                                              fontSize: 12.sp),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              child: LinearProgressIndicator(
                                                color: Color(0xffFFB400),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                value: star4.length == 0
                                                    ? 0.0
                                                    : star4.length /
                                                        snapshot
                                                            .data!.docs.length,
                                                minHeight: 8.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Row(
                                        children: [
                                          CommonText.textBoldWight500(
                                              color:
                                                  CommonColor.greyColor838589,
                                              text: "3",
                                              fontSize: 12.sp),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              child: LinearProgressIndicator(
                                                color: Color(0xffFFB400),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                value: star3.length == 0
                                                    ? 0.0
                                                    : star3.length /
                                                        snapshot
                                                            .data!.docs.length,
                                                minHeight: 8.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Row(
                                        children: [
                                          CommonText.textBoldWight500(
                                              color:
                                                  CommonColor.greyColor838589,
                                              text: "2",
                                              fontSize: 12.sp),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              child: LinearProgressIndicator(
                                                color: Color(0xffFFB400),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                value: star2.length == 0
                                                    ? 0.0
                                                    : star2.length /
                                                        snapshot
                                                            .data!.docs.length,
                                                minHeight: 8.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Row(
                                        children: [
                                          CommonText.textBoldWight500(
                                              color:
                                                  CommonColor.greyColor838589,
                                              text: "1",
                                              fontSize: 12.sp),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              child: LinearProgressIndicator(
                                                color: Color(0xffFFB400),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                value: star1.length == 0
                                                    ? 0.0
                                                    : star1.length /
                                                        snapshot
                                                            .data!.docs.length,
                                                minHeight: 8.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        CommonText.textBoldWight700(
                                            text: "${everageRating}",
                                            fontSize: 15.sp),
                                        Icon(
                                          Icons.star,
                                          size: 18.sp,
                                          color: Color(0xffFFB400),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    CommonText.textBoldWight400(
                                        text:
                                            "${snapshot.data!.docs.length} Reviews",
                                        fontSize: 12.sp,
                                        color: Color(0xff5B5B5B)),
                                    SizedBox(
                                      height: 15.sp,
                                    ),
                                    CommonText.textBoldWight700(
                                        text: "88%", fontSize: 15.sp),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    CommonText.textBoldWight400(
                                        text: "Recommended",
                                        fontSize: 12.sp,
                                        color: Color(0xff5B5B5B)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 21.sp,
                            ),
                            InkWell(
                              onTap: () async {
                                await buildRatingShowDialog(context);
                              },
                              child: Container(
                                  height: 40.sp,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: CommonText.textBoldWight400(
                                        text: "Write a review",
                                        fontSize: 16.sp,
                                        color: Color(0xff5B5B5B)),
                                  )),
                            ),
                            SizedBox(
                              height: 31.sp,
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: Image.network(
                                              '${data['image']}',
                                              height: 32.sp,
                                              width: 32.sp,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CommonText.textBoldWight500(
                                            text: "${data['name']}",
                                            fontSize: 13.sp,
                                            color: Colors.black,
                                          ),
                                          Spacer(),
                                          RatingBarIndicator(
                                            rating: double.parse(
                                                data['rating'].toString()),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 16.sp,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 40.sp),
                                        child: CommonText.textBoldWight400(
                                          text: "${data['des']}",
                                          fontSize: 12.sp,
                                          color: Color(0xff5B5B5B),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: snapshot.data!.docs.length),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  CommonText.textBoldWight700(
                      text: "Similar Products", fontSize: 15.sp),
                  SizedBox(
                    height: 15.sp,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Admin')
                        .doc('all_product')
                        .collection('product_data')
                        .where('category',
                            isEqualTo: '${widget.productData['category']}')
                        // .where('productId',
                        //     isNotEqualTo: '${widget.productData['productId']}')
                        .orderBy('create_time', descending: true)
                        .limit(10)
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.sp / 3.7.sp,
                                  crossAxisSpacing: 0),
                          itemBuilder: (context, index) {
                            var fetchMenData = snapshot.data.docs![index];

                            return ProductTile(
                              onTap: () {
                                if (GetStorageServices
                                        .getUserLoggedInStatus() ==
                                    true) {
                                  print('call la');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(
                                          productData: fetchMenData,
                                        ),
                                      ));
                                  // Get.to(() => ProductDetailScreen(
                                  //       productData: fetchMenData,
                                  //     ));
                                } else {
                                  Get.to(() => SignInScreen());
                                }
                              },
                              image: fetchMenData['listOfImage'][0],
                              title: fetchMenData['productName'],
                              subtitle: fetchMenData['brand'],
                              price: fetchMenData['price'],
                              oldPrice: fetchMenData['oldPrice'],
                              stock: fetchMenData['quantity'],
                              rating: "(200 Ratings)",
                              productID: int.parse(fetchMenData['productId']),
                              needBottomMargin: true,
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
            // CommonWidget.commonSizedBox(height: 14),
            // Center(
            //   child: CommonText.textBoldWight500(
            //       text: 'Did you like the Product?',
            //       color: Colors.black,
            //       fontSize: 18.sp),
            // ),
            SizedBox(
              height: 55.sp,
            ),
          ],
        ),
      ),
    );
  }

  buildRatingShowDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  height: 300.sp,
                  width: 270.sp,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(17),
                          color: Colors.teal,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  setStat(() {
                                    rating = 0;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Review',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (value) {
                                    setStat(() {
                                      rating = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              TextField(
                                controller: description,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: outlineBorder,
                                  focusedBorder: outlineBorder,
                                  enabledBorder: outlineBorder,
                                  fillColor: Colors.grey.shade50,
                                  filled: true,
                                  contentPadding: const EdgeInsets.only(
                                    top: 25,
                                    left: 10,
                                  ),
                                  hintText: 'Write here...',
                                ),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 43.sp,
                                    width: 180.sp,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.teal),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('ProductRating')
                                            .doc(
                                                widget.productData['productId'])
                                            .collection('Rating')
                                            .add({
                                          'name':
                                              GetStorageServices.getNameValue(),
                                          'image': GetStorageServices
                                              .getProfileImageValue(),
                                          'des': description.text.toString(),
                                          'rating': rating
                                        });
                                        Get.back();
                                        rating = 0;
                                        description.clear();
                                      },
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));
  Widget contactUsButton() {
    return MaterialButton(
      onPressed: () {
        launchWhatsapp();
      },
      color: CommonColor.themColor309D9D,
      height: 45.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/image/whatsapp.png", height: 30.sp, width: 30.sp),
          SizedBox(
            width: 10.sp,
          ),
          CommonText.textBoldWight600(
              text: "Contact us", color: Colors.white, fontSize: 12.sp)
        ],
      ),
    );
  }

  Widget likeWidget(AsyncSnapshot<dynamic> snapshot) {
    try {
      return snapshot.data['list_of_like']
              .contains(int.parse(widget.productData['productId']))
          ? Image.asset(
              color: Colors.red,
              'assets/image/favorite.png',
              height: 20,
              width: 20,
            )
          : CommonWidget.commonSvgPitcher(
              image: 'assets/image/favourite.svg', height: 20, width: 20);
    } catch (e) {
      //'assets/image/favourite.svg',
      return CommonWidget.commonSvgPitcher(
          image: 'assets/image/favourite.svg', height: 20, width: 20);
    }
  }

  likeUnLike({required int productId}) async {
    final equipmentCollection = FirebaseFirestore.instance
        .collection("All_User_Details")
        .doc(GetStorageServices.getToken());

    final docSnap = await equipmentCollection.get();
    List queue;
    try {
      queue = docSnap.get('list_of_like');
    } catch (e) {
      await FirebaseFirestore.instance
          .collection("All_User_Details")
          .doc(GetStorageServices.getToken())
          .set({"list_of_like": []});
      queue = docSnap.get('list_of_like');
    }
    if (queue.contains(productId) == true) {
      equipmentCollection.update({
        "list_of_like": FieldValue.arrayRemove([productId])
      }).then((value) {
        setState(() {
          isContainCheck = false;
        });
      });
    } else {
      equipmentCollection.update({
        "list_of_like": FieldValue.arrayUnion([productId])
      }).then((value) {
        isContainCheck = true;
      });
    }
    setState(() {});
  }

  Padding bacButtonWidget() {
    return Padding(
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
              padding: EdgeInsets.only(
                right: 8.sp,
                top: 8.sp,
                bottom: 8.sp,
              ),
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
