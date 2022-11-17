import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/get_storage_services/get_storage_service.dart';
import 'package:sizer/sizer.dart';

import '../constant/color_const.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.7,
        centerTitle: true,
        title: CommonText.textBoldWight700(
            text: 'Notification', color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('All_User_Details')
              .doc(GetStorageServices.getToken())
              .collection('Notification')
              .get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var _res = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            border: Border.all(
                                color: CommonColor.greyColor3D3D3D
                                    .withOpacity(0.2),
                                width: 0.5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText.textBoldWight700(
                                text: 'Inzoid',
                                color: Colors.black,
                                fontSize: 16),
                            Flexible(
                              child: CommonText.textBoldWight600(
                                  text: '${_res['msg']}',
                                  color: Colors.grey,
                                  fontSize: 9.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
