import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/image_const.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/home_screen.dart';
import 'package:inzoid/view/sign_in_screen.dart';
import 'package:sizer/sizer.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController _passWordController = TextEditingController();
  TextEditingController _passWordConfirmController = TextEditingController();

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
                  text: TextConst.updatePassword,
                  fontSize: 20.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 6),
              CommonText.textBoldWight400(
                  text: TextConst.enterYourNewPassword,
                  fontSize: 12.sp,
                  color: CommonColor.greyColor838589),
              CommonWidget.commonSizedBox(height: 40),
              CommonText.textBoldWight400(
                  text: TextConst.newPassword,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  isObscured: isObscuredPassword,
                  controller: _passWordController,
                  hintText: TextConst.newPassword,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscuredPassword = !isObscuredPassword;
                        });
                      },
                      icon: Icon(
                        isObscuredPassword
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
              CommonWidget.commonSizedBox(height: 36),
              CommonText.textBoldWight400(
                  text: TextConst.confirmNewPassword,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  isObscured: isObscuredConfirm,
                  controller: _passWordConfirmController,
                  hintText: TextConst.confirmNewPassword,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscuredConfirm = !isObscuredConfirm;
                        });
                      },
                      icon: Icon(
                        isObscuredConfirm
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: CommonColor.greyColor838589,
                        //size: 10,
                      ))),
              CommonWidget.commonSizedBox(height: 50),
              CommonWidget.commonButton(
                  onTap: () {
                    if (_passWordConfirmController.text.isNotEmpty &&
                        _passWordController.text.isNotEmpty) {
                      if (_passWordController.text.length >= 6) {
                        if (_passWordConfirmController.text ==
                            _passWordController.text) {
                          Get.offAll(() => HomeScreen());
                        } else {
                          CommonWidget.getSnackBar(
                              title: TextConst.failed,
                              color: CommonColor.red,
                              duration: 2,
                              message:
                                  'Confirm Password must be same as above');
                        }
                      } else {
                        CommonWidget.getSnackBar(
                            title: TextConst.failed,
                            color: CommonColor.red,
                            duration: 2,
                            message: 'Password must be at least 6 digit');
                      }
                    } else {
                      CommonWidget.getSnackBar(
                          title: TextConst.failed,
                          color: CommonColor.red,
                          duration: 2,
                          message:
                              'Password or Confirm Password can not be empty');
                    }
                  },
                  text: TextConst.saveUpdate),
            ]),
          ),
        ),
      ),
    );
  }
}
