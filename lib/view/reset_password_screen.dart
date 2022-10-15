import 'package:flutter/material.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/image_const.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/verification_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColorfffff,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CommonWidget.commonSizedBox(height: 28),
              InkResponse(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    ImageConst.arrowBack,
                    height: 12.sp,
                    width: 12.sp,
                  )),
              CommonWidget.commonSizedBox(height: 28),
              CommonText.textBoldWight700(
                  text: TextConst.resetPassword,
                  fontSize: 20.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 6),
              CommonText.textBoldWight400(
                  text: TextConst.RegisteredMobileOrEmail,
                  fontSize: 12.sp,
                  color: CommonColor.greyColor838589),
              CommonWidget.commonSizedBox(height: 30),
              CommonText.textBoldWight400(
                  text: TextConst.emailPhone,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  controller: _emailController, hintText: TextConst.emailPhone),
              CommonWidget.commonSizedBox(height: 40),
              CommonWidget.commonButton(
                  onTap: () {
                    if (_emailController.text.isNotEmpty) {
                      Get.to(() => VerificationScreen(
                            emailOrPhoneText: _emailController.text,
                          ));
                    } else {
                      CommonWidget.getSnackBar(
                          title: TextConst.failed,
                          color: CommonColor.red,
                          duration: 2,
                          message: 'Email or Phone can not be empty');
                    }
                  },
                  text: TextConst.reset),
            ]),
          ),
        ),
      ),
    );
  }
}
