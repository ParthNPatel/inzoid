import 'package:flutter/material.dart';
import 'package:inzoid/constant/text_styel.dart';

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
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
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
                          color: CommonColor.greyColor3D3D3D.withOpacity(0.2),
                          width: 0.5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                                    text: 'Admin',
                                    color: Colors.black,
                                    fontSize: 16),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 5.0, 10.0, 5.0),
                                  height: 25,
                                  child: CommonText.textBoldWight600(
                                      text: 'hi iam admin',
                                      color: Colors.grey,
                                      fontSize: 10),
                                ),
                              ],
                            )),
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
