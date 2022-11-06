import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/product_detail_screen.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:sizer/sizer.dart';
import '../components/wishlist_shimmer.dart';
import '../constant/text_const.dart';
import '../get_storage_services/get_storage_service.dart';

class MyWishListPage extends StatefulWidget {
  const MyWishListPage({Key? key}) : super(key: key);

  @override
  State<MyWishListPage> createState() => _MyWishListPageState();
}

class _MyWishListPageState extends State<MyWishListPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.7,
        leading: bacButtonWidget(),
        centerTitle: true,
        title:
            CommonText.textBoldWight700(text: 'Wishlist', color: Colors.black),
      ),
      body: _descriptionWidget(),
    ));
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

  Widget _descriptionWidget() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child: GetStorageServices.getUserLoggedInStatus() == true
              ? FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('All_User_Details')
                      .doc(GetStorageServices.getToken())
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      try {
                        return snapshot.data['list_of_like'].length == 0
                            ? Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: Get.height / 2.5),
                                  child: Text('Empty'),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data['list_of_like'].length,
                                itemBuilder: (context, index) {
                                  return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('Admin')
                                        .doc('all_product')
                                        .collection('product_data')
                                        .where('productId',
                                            isEqualTo:
                                                '${snapshot.data['list_of_like'][index]}')
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot snapshotSingle) {
                                      if (snapshotSingle.hasData) {
                                        var getSingleProductData =
                                            snapshotSingle.data.docs[0];
                                        // print(
                                        //     'getSingleProductData  ${getSingleProductData['address']}');
                                        return WishListItemWidget(
                                            onTap: () {
                                              if (GetStorageServices
                                                      .getUserLoggedInStatus() ==
                                                  true) {
                                                Get.to(
                                                    () => ProductDetailScreen(
                                                          productData:
                                                              getSingleProductData,
                                                        ));
                                              } else {
                                                Get.to(
                                                    () => const SignInScreen());
                                              }
                                            },
                                            wishListItemModel:
                                                getSingleProductData);
                                      } else {
                                        return WishListShimmer();
                                      }
                                    },
                                  );
                                },
                              );
                      } catch (e) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: Get.height / 2.8),
                            child: Text('No Data Found'),
                          ),
                        );
                      }
                    } else {
                      return WishListShimmer();
                    }
                  },
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height / 2.5),
                    child: Text('Empty'),
                  ),
                )),
    );
  }
}

class WishListItemWidget extends StatefulWidget {
  final wishListItemModel;
  final onTap;
  const WishListItemWidget(
      {Key? key, required this.wishListItemModel, required this.onTap})
      : super(key: key);

  @override
  State<WishListItemWidget> createState() => _WishListItemWidgetState();
}

class _WishListItemWidgetState extends State<WishListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              border: Border.all(
                  color: CommonColor.greyColor3D3D3D.withOpacity(0.2),
                  width: 0.5)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    '${widget.wishListItemModel['listOfImage'][0]}',
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                    width: MediaQuery.of(context).size.width -
                        162, // Full Width - 15padding +15 Padding + 50+10 ( Profile pic width) ,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText.textBoldWight700(
                            text: '${widget.wishListItemModel['productName']}',
                            color: Colors.black,
                            fontSize: 16),
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
                          height: 25,
                          child: CommonText.textBoldWight600(
                              text:
                                  '${widget.wishListItemModel['subCategory'] ?? ""}',
                              color: Colors.grey,
                              fontSize: 10),
                        ),
                        Container(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                            child: RichText(
                              text: TextSpan(
                                text: String.fromCharCodes(Runes('')),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                    color: CommonColor.blackColor0C1A30,
                                    fontFamily: TextConst.fontFamily),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${widget.wishListItemModel['price']}',
                                      // GoogleFonts.urbanist(
                                      //     fontWeight: FontWeight.w700,
                                      //     fontSize: 14.0,
                                      //     color: ConstColors.darkColor)
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                          color: CommonColor.blackColor0C1A30,
                                          fontFamily: TextConst.fontFamily)),
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 5.0, right: 0.0, bottom: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonText.textBoldWight600(
                                  text: "⭐ 4.2   ",
                                  color: Colors.yellow,
                                  fontSize: 12),
                              CommonText.textBoldWight600(
                                  text:
                                      "⚈ ${widget.wishListItemModel['category']}",
                                  color: Colors.black,
                                  fontSize: 12),
                            ],
                          ),
                        ),
                      ],
                    )),
              ]),
        ),
      ),
    );
  }
}
