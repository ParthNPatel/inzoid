import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/get_storage_services/get_storage_service.dart';
import 'package:inzoid/view/home_screen.dart';
import 'package:inzoid/view/reset_password_screen.dart';
import 'package:inzoid/view/sign_up_screen.dart';
import 'package:inzoid/view/verification_screen.dart';
import 'package:sizer/sizer.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  bool isObscured = true;
  String? verificationId;

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
              CommonWidget.commonSizedBox(height: 60),
              CommonText.textBoldWight700(
                  text: TextConst.welcomeBackTo,
                  fontSize: 20.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 6),
              CommonText.textBoldWight700(
                  text: TextConst.inzoid,
                  fontSize: 20.sp,
                  color: CommonColor.themColor309D9D),
              CommonWidget.commonSizedBox(height: 30),
              CommonText.textBoldWight400(
                  text: TextConst.emailPhone,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  controller: _emailController, hintText: TextConst.email),
              CommonWidget.commonSizedBox(height: 26),
              CommonText.textBoldWight400(
                  text: TextConst.password,
                  fontSize: 12.sp,
                  color: CommonColor.blackColor0C1A30),
              CommonWidget.commonSizedBox(height: 14),
              CommonWidget.textFormField(
                  isObscured: isObscured,
                  controller: _passWordController,
                  hintText: TextConst.password,
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      child: Icon(
                        isObscured
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: CommonColor.greyColor838589,
                        //size: 10,
                      ))),
              CommonWidget.commonSizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Get.to(() => ResetPasswordScreen());
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: CommonText.textBoldWight500(
                        text: TextConst.forgotPassword,
                        fontSize: 12.sp,
                        color: CommonColor.blackColor0C1A30)),
              ),
              CommonWidget.commonSizedBox(height: 40),
              CommonWidget.commonButton(
                  onTap: () {
                    if (_emailController.text.isNotEmpty &&
                        _passWordController.text.isNotEmpty) {
                      bool emailValid = RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(_emailController.text);

                      if (emailValid == true) {
                        GetStorageServices.setUserName(
                            username: _emailController.text);
                        GetStorageServices.setUserLoggedIn();
                        Get.off(() => HomeScreen());
                      } else {
                        CommonWidget.getSnackBar(
                            title: TextConst.failed,
                            color: CommonColor.red,
                            duration: 2,
                            message: TextConst.enterValidEmail);
                      }
                    } else {
                      CommonWidget.getSnackBar(
                          title: TextConst.failed,
                          color: CommonColor.red,
                          duration: 2,
                          message: TextConst.canNotBeEmpty);
                    }
                  },
                  text: TextConst.signIn),
              CommonWidget.commonSizedBox(height: 20),
              Align(
                  alignment: Alignment.center,
                  child: CommonText.textBoldWight500(
                      text: TextConst.continueAsGuest,
                      fontSize: 12.sp,
                      color: CommonColor.greyColor3D3D3D)),
              CommonWidget.commonSizedBox(height: 20),
              // InkWell(
              //   onTap: () {
              //     Get.to(() => SignUpScreen());
              //   },
              //   child: Align(
              //       alignment: Alignment.center,
              //       child: CommonText.textBoldWight500(
              //           text: TextConst.signUp,
              //           fontSize: 12.sp,
              //           color: CommonColor.themColor309D9D)),
              // )
            ]),
          ),
        ),
      ),
    );
  }

  signInMethod() async {
    try {
      if (_emailController.text.length == 10) {
        await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + _emailController.text,
          verificationCompleted: (phoneAuthCredential) async {
            // setState(() {
            //   showLoading = false;
            // });
            // signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          verificationFailed: (verificationFailed) async {
            // setState(() {
            //   showLoading = false;
            // });
            print('----verificationFailed---${verificationFailed.message}');
            CommonWidget.getSnackBar(
              message: verificationFailed.message!,
              title: 'Failed',
              duration: 2,
              color: Colors.red,
            );
          },
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              //  showLoading = false;
              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
              this.verificationId = verificationId;

              Get.to(VerificationScreen(
                emailOrPhoneText: '+91' + _emailController.text,
                verificationId: verificationId,
              ));
            });
          },
          codeAutoRetrievalTimeout: (verificationId) async {},
        );
      } else {
        CommonWidget.getSnackBar(
            message: 'Please enter your mobile number',
            color: Colors.red,
            title: '');
      }
    } on FirebaseException catch (e) {
      CommonWidget.getSnackBar(
          message: '${e.message}',
          color: Colors.red,
          title: 'Failed',
          duration: 2);
      print('MAG ERROR----${e.message}');
    }
  }
}
