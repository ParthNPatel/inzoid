import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:sizer/sizer.dart';
import '../components/category_shimmer.dart';
import '../constant/text_styel.dart';

class BrandManiaScreen extends StatefulWidget {
  const BrandManiaScreen({Key? key}) : super(key: key);

  @override
  State<BrandManiaScreen> createState() => _BrandManiaScreenState();
}

class _BrandManiaScreenState extends State<BrandManiaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Admin')
            .doc('brands')
            .collection('brand_list')
            .get(),
        builder: (BuildContext context, AsyncSnapshot data) {
          if (data.hasData) {
            var brandManiaList = data.data.docs;
            return ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 100.sp,
                  width: 120.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              brandManiaList[index]['brand_image'][0]),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 30.sp,
                          width: 120.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(9)),
                          ),
                          child: Center(
                            child: Image.network(
                              brandManiaList[index]['brand_icon'][0],
                              height: 15.sp,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return BrandsShimmerVertical();
          }
        },
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
          text: TextConst.brandMania, color: Colors.black),
    );
  }
}
