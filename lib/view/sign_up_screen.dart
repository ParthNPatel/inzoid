import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../components/common_widget.dart';
import '../constant/color_const.dart';
import '../constant/const_size.dart';
import '../constant/image_const.dart';
import '../constant/text_const.dart';
import '../constant/text_styel.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  TextEditingController _referalCodeController = TextEditingController();

  bool isObscuredPassword = true;
  bool isObscuredConfirm = true;
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
              CommonWidget.commonSizedBox(height: 50),
              CommonText.textBoldWight700(
                  text: TextConst.profileAndPassword,
                  fontSize: 20.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 6),
              CommonText.textBoldWight400(
                  text: TextConst.stepUp,
                  fontSize: 12.sp,
                  color: CommonColor.greyColor838589),
              CommonWidget.commonSizedBox(height: 40),
              CommonText.textBoldWight400(
                  text: TextConst.fullName,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                controller: _fullNameController,
                hintText: TextConst.fullName,
              ),
              CommonWidget.commonSizedBox(height: 36),
              CommonText.textBoldWight400(
                  text: TextConst.password,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  isObscured: isObscuredConfirm,
                  controller: _passWordController,
                  hintText: TextConst.password,
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscuredConfirm = !isObscuredConfirm;
                        });
                      },
                      child: Icon(
                        isObscuredConfirm
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: CommonColor.greyColor838589,
                        //size: 10,
                      ))),
              CommonWidget.commonSizedBox(height: 10),
              Row(children: [
                CommonWidget.commonSvgPitcher(
                    image: ImageConst.info, height: 12.sp, width: 12.sp),
                CommonWidget.commonSizedBox(width: 6),
                CommonText.textBoldWight400(
                    text: TextConst.moreThen6,
                    fontSize: 12.sp,
                    color: CommonColor.greyColor838589)
              ]),
              CommonWidget.commonSizedBox(height: 40),
              CommonText.textBoldWight400(
                  text: TextConst.referalCode,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                controller: _referalCodeController,
                hintText: TextConst.inputYourCode,
              ),
              CommonWidget.commonSizedBox(height: 50),
              CommonWidget.commonButton(
                  onTap: () {
                    if (_fullNameController.text.isNotEmpty &&
                        _passWordController.text.isNotEmpty) {
                      Get.off(() => HomeScreen());
                    } else {
                      CommonWidget.getSnackBar(
                          title: TextConst.failed,
                          color: CommonColor.red,
                          duration: 2,
                          message: 'Full Name or Password can not be empty');
                    }
                  },
                  text: TextConst.letsGo),
            ]),
          ),
        ),
      ),
    );
  }
}
