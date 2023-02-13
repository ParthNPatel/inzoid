import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/image_const.dart';
import 'package:inzoid/get_storage_services/get_storage_service.dart';
import 'package:sizer/sizer.dart';
import '../constant/color_const.dart';
import '../constant/text_styel.dart';
import '../view/sign_in_screen.dart';
import 'common_widget.dart';

class ProductTile extends StatefulWidget {
  final image;
  final title;
  final subtitle;
  final price;
  final oldPrice;
  final rating;
  final onTap;
  final stock;
  final int productID;
  const ProductTile(
      {super.key,
      required this.image,
      required this.productID,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.oldPrice,
      required this.rating,
      required this.onTap,
      this.stock});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isContainCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CommonColor.greyColorD4D4D4, width: 1.6),
      ),
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  height: 145.sp,
                  // width: 130.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: CommonColor.greyColorF2F2F2,
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 5.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWight700(
                          text: widget.title, fontSize: 10.sp),
                      SizedBox(
                        height: 2.sp,
                      ),
                      CommonText.textBoldWight400(
                          text: widget.subtitle,
                          fontSize: 8.sp,
                          color: CommonColor.greyColor838589),
                      SizedBox(
                        height: 5.sp,
                      ),
                      CommonText.textBoldWight700(
                          text: '₹ ${widget.price}', fontSize: 10.sp),
                    ],
                  ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // SizedBox(
              //     //   width: 2.w,
              //     // ),
              //     // CommonText.textBoldWight700(
              //     //     color: CommonColor.greyColorD9D9D9,
              //     //     textDecoration: TextDecoration.lineThrough,
              //     //     text: widget.oldPrice,
              //     //     fontSize: 10.sp),
              //   ],
              // ),
              SizedBox(
                height: 2.sp,
              ),
              Divider(
                thickness: 1.5,
                color: Color(0xffD4D4D4),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Row(
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
                        text: '${widget.stock} Pieces IN STOCK',
                        fontSize: 8.sp,
                        color: CommonColor.greyColor838589),
                  ],
                ),
              )

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List.generate(
              //       5,
              //       (index) => Icon(
              //             Icons.star,
              //             size: 11.sp,
              //             color: CommonColor.yellowColor,
              //           )),
              // ),
              // SizedBox(
              //   height: 5.sp,
              // ),
              // CommonText.textBoldWight400(
              //     text: widget.rating,
              //     fontSize: 6.sp,
              //     color: CommonColor.greyColor838589),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0, top: 10),
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  try {
                    print('like not goo  ${widget.productID}');
                    isContainCheck = snapshot.data['list_of_like']
                        .contains(widget.productID);
                    print(
                        'list_of_like  ${snapshot.data['list_of_like'].contains(widget.productID)}');
                  } catch (e) {
                    isContainCheck = false;
                  }

                  return GestureDetector(
                    onTap: () {
                      if (GetStorageServices.getUserLoggedInStatus() == true) {
                        likeUnLike(productId: widget.productID);
                      } else {
                        Get.to(() => SignInScreen());
                      }
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
        ],
      ),
    );
  }

  Widget likeWidget(AsyncSnapshot<dynamic> snapshot) {
    try {
      return snapshot.data['list_of_like'].contains(widget.productID)
          ? Image.asset(
              color: Colors.red,
              'assets/image/favorite.png',
              height: 20,
              width: 20,
            )
          : CommonWidget.commonSvgPitcher(
              image: 'assets/image/favourite.svg', height: 17, width: 17);
    } catch (e) {
      return CommonWidget.commonSvgPitcher(
          image: 'assets/image/favourite.svg', height: 17, width: 17);
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
}
