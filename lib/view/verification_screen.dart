import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/view/update_password_screen.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import '../components/common_widget.dart';
import '../constant/color_const.dart';
import '../constant/const_size.dart';
import '../constant/image_const.dart';
import '../constant/text_styel.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerificationScreen extends StatefulWidget {
  final String emailOrPhoneText;
  const VerificationScreen({Key? key, required this.emailOrPhoneText})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? verificationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColorfffff,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    text: TextConst.verification,
                    fontSize: 20.sp,
                    color: CommonColor.blackColor0C1A30),
                CommonWidget.commonSizedBox(height: 6),
                CommonText.textBoldWight400(
                    text:
                        TextConst.optSentSuccessfully + widget.emailOrPhoneText,
                    fontSize: 12.sp,
                    color: CommonColor.greyColor838589),
                CommonWidget.commonSizedBox(height: 8),
                CommonText.textBoldWight400(
                    text: TextConst.changeMobile,
                    fontSize: 12.sp,
                    color: CommonColor.themColor309D9D),
                CommonWidget.commonSizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textBoldWight500(
                        text: TextConst.verificationCode,
                        fontSize: 11.sp,
                        color: CommonColor.blackColor0C1A30),
                    InkWell(
                      onTap: () {},
                      child: CommonText.textBoldWight500(
                          text: TextConst.resendCode,
                          fontSize: 11.sp,
                          color: CommonColor.themColor309D9D),
                    )
                  ],
                ),
                CommonWidget.commonSizedBox(height: 20),
                OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 70,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: CommonColor.textFiledColorFAFAFA,
                    borderColor: Colors.transparent,
                    disabledBorderColor: Colors.transparent,
                    enabledBorderColor: Colors.transparent,
                    errorBorderColor: Colors.transparent,
                    focusBorderColor: Colors.transparent,
                  ),
                  onCompleted: (pin) {
                    setState(() {
                      verificationCode = pin;
                    });
                  },
                ),
                CommonWidget.commonSizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonText.textBoldWight500(
                      text: "03:05",
                      fontSize: 11.sp,
                      color: CommonColor.greyColor838589),
                ),
                CommonWidget.commonSizedBox(height: 50),
                CommonWidget.commonButton(
                    onTap: () {
                      if (verificationCode != null) {
                        Get.to(() => UpdatePasswordScreen());
                      } else {
                        CommonWidget.getSnackBar(
                            title: TextConst.failed,
                            color: CommonColor.red,
                            duration: 2,
                            message: 'Verification Code can not be empty');
                      }
                    },
                    text: TextConst.continueText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
