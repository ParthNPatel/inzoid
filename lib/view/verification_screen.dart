import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inzoid/components/common_method.dart';
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

import '../get_storage_services/get_storage_service.dart';
import 'bottom_bar_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String emailOrPhoneText;
  final String verificationId;
  final bool isEmail;
  const VerificationScreen(
      {Key? key,
      required this.emailOrPhoneText,
      required this.verificationId,
      required this.isEmail})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? verificationCode;
  FirebaseAuth _auth = FirebaseAuth.instance;
  OtpFieldController _controller = OtpFieldController();
  EmailAuth? emailAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEmail) {
      emailAuth = new EmailAuth(
        sessionName: "Sample session",
      );
      emailAuth!.config({
        "server": "server url",
        "serverKey": "AIzaSyCoJPlgKxXEy3FprIJYE5nPqaLC_gL94jI"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColorfffff,
      body: ProgressHUD(child: Builder(
        builder: (context) {
          final progress = ProgressHUD.of(context);

          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
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
                        text: TextConst.optSentSuccessfully +
                            widget.emailOrPhoneText,
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
                      controller: _controller,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 42,
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
                        verificationCode = pin;
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
                        onTap: () async {
                          if (verificationCode != null) {
                            if (widget.isEmail) {
                              bool validOtp = emailAuth!.validateOtp(
                                  recipientMail: widget.emailOrPhoneText,
                                  userOtp: verificationCode!);
                              print('---test email  $validOtp');
                              // 716432
                              if (validOtp) {
                                GetStorageServices.setToken(
                                    widget.emailOrPhoneText);
                                GetStorageServices.setUserLoggedIn();
                                //Get.offAll(() => BottomNavScreen());
                              } else {
                                CommonWidget.getSnackBar(
                                    title: TextConst.failed,
                                    color: CommonColor.red,
                                    duration: 2,
                                    message: 'Please Enter Valid otp');
                              }
                            } else {
                              PhoneAuthCredential phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: widget.verificationId,
                                      smsCode: verificationCode!);

                              await signInWithPhoneAuthCredential(
                                  phoneAuthCredential: phoneAuthCredential,
                                  progress: progress);
                            }

                            GetStorageServices.setIsEmailOrPhone(false);

                            GetStorageServices.setToken(
                                FirebaseAuth.instance.currentUser!.uid);

                            await CommonMethod.likeFiledAdd(context);

                            // Get.to(() => UpdatePasswordScreen());
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
          );
        },
      )),
    );
  }

  signInWithPhoneAuthCredential({
    required PhoneAuthCredential phoneAuthCredential,
    required final progress,
  }) async {
    progress.show();

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        String uid = _auth.currentUser!.uid.toString();
        print('---------uid in current user $uid');
        GetStorageServices.setToken(uid);
        GetStorageServices.setUserLoggedIn();
      }
    } on FirebaseAuthException catch (e) {
      progress.dismiss();

      CommonWidget.getSnackBar(
          message: '${e.message}',
          title: 'Failed',
          duration: 2,
          color: Colors.red);
    }
  }
}
