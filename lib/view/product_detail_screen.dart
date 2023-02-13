import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  /// WhatsApp Share:

  void launchWhatsapp() {
    launch(WhatsAppUnilink(
      phoneNumber: "919999713112",
      text: "Hello Admin, Wanted to inquire about the product",
    ).toString());
  }

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CommonText.textBoldWight500(
                                    color: CommonColor.greyColor838589,
                                    text: "5",
                                    fontSize: 12.sp),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      color: Color(0xffFFB400),
                                      backgroundColor: Colors.grey.shade200,
                                      value: 1,
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
                                    color: CommonColor.greyColor838589,
                                    text: "4",
                                    fontSize: 12.sp),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      color: Color(0xffFFB400),
                                      backgroundColor: Colors.grey.shade200,
                                      value: 0.8,
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
                                    color: CommonColor.greyColor838589,
                                    text: "3",
                                    fontSize: 12.sp),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      color: Color(0xffFFB400),
                                      backgroundColor: Colors.grey.shade200,
                                      value: 0.6,
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
                                    color: CommonColor.greyColor838589,
                                    text: "2",
                                    fontSize: 12.sp),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      color: Color(0xffFFB400),
                                      backgroundColor: Colors.grey.shade200,
                                      value: 0.4,
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
                                    color: CommonColor.greyColor838589,
                                    text: "1",
                                    fontSize: 12.sp),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: LinearProgressIndicator(
                                      color: Color(0xffFFB400),
                                      backgroundColor: Colors.grey.shade200,
                                      value: 0.2,
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
                      Row(
                        children: [
                          CommonText.textBoldWight700(
                              text: "4.5", fontSize: 15.sp),
                          Icon(
                            Icons.star,
                            size: 18.sp,
                            color: Color(0xffFFB400),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
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
                                  childAspectRatio: 2.sp / 3.8.sp,
                                  crossAxisSpacing: 15),
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
                              rating: "(200 Ratings)",
                              productID: int.parse(fetchMenData['productId']),
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
