import 'package:country_picker/country_picker.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:inzoid/components/common_method.dart';
import 'package:inzoid/components/common_widget.dart';
import 'package:inzoid/constant/color_const.dart';
import 'package:inzoid/constant/const_size.dart';
import 'package:inzoid/constant/text_const.dart';
import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/reset_password_screen.dart';
import 'package:inzoid/view/verification_screen.dart';
import 'package:sizer/sizer.dart';

import '../get_storage_services/get_storage_service.dart';

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
  TextEditingController _emailMobileController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  EmailAuth? emailAuth;

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  bool isObscured = true;
  String? verificationId;
  bool? emailValid;
  bool isChecked = false;
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColorfffff,
      body: ProgressHUD(child: Builder(
        builder: (context) {
          final progress = ProgressHUD.of(context);

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: CommonSize.screenPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          text: isChecked ? TextConst.email : TextConst.mobile,
                          fontSize: 12.sp,
                          color: CommonColor.blackColor0C1A30),
                      CommonWidget.commonSizedBox(height: 14),
                      isChecked == true
                          ? CommonWidget.textFormField(
                              controller: _emailMobileController,
                              hintText: TextConst.email)
                          : CommonWidget.textFormField(
                              prefix: SizedBox(
                                width: 30.sp,
                                child: InkWell(
                                  onTap: () {
                                    // _displayDialog(context);
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode:
                                          true, // optional. Shows phone code before the country name.
                                      onSelect: (Country country) {
                                        print(
                                            'Select country: ${country.displayName}');
                                        setState(() {
                                          selectedCountry = country;
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      width: 100,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            selectedCountry != null
                                                ? "+ ${selectedCountry!.phoneCode}"
                                                : "+91",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              keyBoardType: TextInputType.number,
                              controller: _emailMobileController,
                              hintText: TextConst.mobile),
                      CommonWidget.commonSizedBox(height: 8),
                      Row(
                        children: [
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: FittedBox(
                              child: Checkbox(
                                value: isChecked,
                                activeColor: CommonColor.themColor309D9D,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          CommonText.textBoldWight500(
                              text: "Continue with Email")
                        ],
                      ),

                      // CommonText.textBoldWight400(
                      //     text: TextConst.password,
                      //     fontSize: 12.sp,
                      //     color: CommonColor.blackColor0C1A30),
                      // CommonWidget.commonSizedBox(height: 14),
                      // CommonWidget.textFormField(
                      //     isObscured: isObscured,
                      //     controller: _passWordController,
                      //     hintText: TextConst.password,
                      //     suffix: GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             isObscured = !isObscured;
                      //           });
                      //         },
                      //         child: Icon(
                      //           isObscured
                      //               ? Icons.remove_red_eye_outlined
                      //               : Icons.visibility_off_outlined,
                      //           color: CommonColor.greyColor838589,
                      //           //size: 10,
                      //         ))),
                      // CommonWidget.commonSizedBox(height: 8),
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
                            if (_emailMobileController.text.isNotEmpty) {
                              if (isChecked) {
                                emailAuth = new EmailAuth(
                                  sessionName: "Sample session",
                                );
                                emailAuth!.config({
                                  "server": "server url",
                                  "serverKey":
                                      "AIzaSyCoJPlgKxXEy3FprIJYE5nPqaLC_gL94jI"
                                });
                                _emailProceedAction(progress);
                              } else {
                                signInMethod(progress);
                              }
                            } else {
                              CommonWidget.getSnackBar(
                                  title: TextConst.failed,
                                  color: CommonColor.red,
                                  duration: 2,
                                  message: isChecked
                                      ? TextConst.emailCanNotBeEmpty
                                      : TextConst.mobileCanNotBeEmpty);
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
          );
        },
      )),
    );
  }

  signInMethod(
    final progress,
  ) async {
    try {
      if (_emailMobileController.text.length == 10) {
        progress.show();
        await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + _emailMobileController.text,
          verificationCompleted: (phoneAuthCredential) async {
            progress.dismiss();
          },
          verificationFailed: (verificationFailed) async {
            progress.dismiss();

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
                isEmail: false,
                emailOrPhoneText: '+91' + _emailMobileController.text,
                verificationId: verificationId,
              ));
              progress.dismiss();
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

  Future<void> _emailProceedAction(
    final progress,
  ) async {
    try {
      if (_emailMobileController.text.isNotEmpty) {
        if (emailValid == true) {
          progress!.show();
          bool result = await emailAuth!.sendOtp(
              recipientMail: _emailMobileController.value.text.trim(),
              otpLength: 6);
          if (result) {
            // showBottomEmailSheet();
            Future.delayed(Duration(milliseconds: 500), () {
              Get.to(VerificationScreen(
                isEmail: true,
                verificationId: '',
                emailOrPhoneText: _emailMobileController.text.trim(),
              ));
            });

            GetStorageServices.setEmail(_emailMobileController.text.trim());

            GetStorageServices.setIsEmailOrPhone(true);

            GetStorageServices.setToken(FirebaseAuth.instance.currentUser!.uid);
            CommonMethod.likeFiledAdd(context);

            progress.dismiss();
          } else {
            progress.dismiss();
            CommonWidget.getSnackBar(
              message: "Something went to wrong",
              color: Colors.red,
              title: 'Failed',
              duration: 2,
            );
          }
        } else {
          CommonWidget.getSnackBar(
            message: "Please enter valid email",
            color: Colors.red,
            title: 'Failed',
            duration: 2,
          );
        }
      } else {
        CommonWidget.getSnackBar(
          message: 'Please enter valid details',
          color: Colors.red,
          title: 'Failed',
          duration: 2,
        );
      }
    } catch (e) {
      progress!.dismiss();
      CommonWidget.getSnackBar(
        message: "Something went wrong",
        color: Colors.red,
        title: 'Failed',
        duration: 2,
      );
    }
  }
}
