import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/reset_password_screen.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

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
              CommonWidget.commonSizedBox(height: 50),
              CommonText.textBoldWight700(
                  text: constText.welcomeBackTo,
                  fontSize: 20.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 6),
              CommonText.textBoldWight700(
                  text: constText.inzoid,
                  fontSize: 20.sp,
                  color: CommonColor.themColor309D9D),
              CommonWidget.commonSizedBox(height: 30),
              CommonText.textBoldWight400(
                  text: constText.emailPhone,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  controller: _emailController, hintText: constText.email),
              CommonWidget.commonSizedBox(height: 26),
              CommonText.textBoldWight400(
                  text: constText.password,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  isObscured: isObscured,
                  controller: _passWordController,
                  hintText: constText.password,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      icon: Icon(
                        isObscured
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: CommonColor.greyColor838589,
                        //size: 10,
                      ))),
              CommonWidget.commonSizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  Get.to(() => ResetPasswordScreen());
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: CommonText.textBoldWight500(
                        text: constText.forgotPassword,
                        fontSize: 12.sp,
                        color: CommonColor.blackColor0C1A30)),
              ),
              CommonWidget.commonSizedBox(height: 40),
              CommonWidget.commonButton(
                  onTap: () {
                    if (_emailController.text.isNotEmpty &&
                        _passWordController.text.isNotEmpty) {
                    } else {
                      CommonWidget.getSnackBar(
                          title: constText.failed,
                          color: CommonColor.red,
                          duration: 2,
                          message: constText.canNotBeEmpty);
                    }
                  },
                  text: constText.signIn),
              CommonWidget.commonSizedBox(height: 20),
              Align(
                  alignment: Alignment.center,
                  child: CommonText.textBoldWight500(
                      text: constText.continueAsGuest,
                      fontSize: 12.sp,
                      color: CommonColor.greyColor3D3D3D)),
              CommonWidget.commonSizedBox(height: 20),
              Align(
                  alignment: Alignment.center,
                  child: CommonText.textBoldWight500(
                      text: constText.signUp,
                      fontSize: 12.sp,
                      color: CommonColor.themColor309D9D)),
            ]),
          ),
        ),
      ),
    );
  }
}
