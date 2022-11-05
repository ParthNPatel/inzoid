import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inzoid/components/common_method.dart';

import 'package:inzoid/constant/text_styel.dart';
import 'package:inzoid/view/bottom_bar_screen.dart';
import '../components/common_widget.dart';
import '../constant/color_const.dart';
import '../get_storage_services/get_storage_service.dart';
import 'package:get/get.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SetProfileScreenState();
  }
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController? emailController;
  TextEditingController? mobileController;

  String? liveImageURL;

  bool isSignIn = false;
  bool google = false;
  File? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        'getIsEmailOrPhone set prof   ${GetStorageServices.getIsEmailOrPhone()}');
    if (GetStorageServices.getIsEmailOrPhone() != null) {
      if (GetStorageServices.getIsEmailOrPhone() == true) {
        emailController =
            TextEditingController(text: GetStorageServices.getEmail());
        mobileController = TextEditingController();
      } else {
        mobileController =
            TextEditingController(text: GetStorageServices.getMobile());
        emailController = TextEditingController();
      }
    } else {
      mobileController = TextEditingController();
      emailController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //resizeToAvoidBottomInset: false,
          body: _body()),
    );
  }

  Widget _body() {
    var width = MediaQuery.of(context).size.width;
    var safearea = MediaQuery.of(context).padding.top;

    return ProgressHUD(child: Builder(
      builder: (context) {
        final progress = ProgressHUD.of(context);

        return SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5)),
                      child: image == null
                          ? Icon(
                              color: Colors.grey,
                              Icons.person,
                              size: 120,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: Image.file(image!, fit: BoxFit.cover)),
                    ),
                    Positioned(
                      //bottom: 20,
                      right: 10,
                      child: CircleAvatar(
                          backgroundColor: CommonColor.themColor309D9D,
                          child: IconButton(
                              onPressed: () {
                                showDialogWidget();
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText.textBoldWight500(text: 'User Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'User Name',
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(5.0),
                      //   borderSide: const BorderSide(
                      //       color: ConstColors.widgetDividerColor, width: 1.0),
                      // ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: themColors309D9D, width: 1.5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText.textBoldWight500(text: 'Full Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Full Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: themColors309D9D, width: 1.5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText.textBoldWight500(text: 'Email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: themColors309D9D, width: 1.5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText.textBoldWight500(text: 'Phone no'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Phone no',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: themColors309D9D, width: 1.5),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print('enter thg escree ');

                    if (image != null ||
                        nameController.text.isNotEmpty &&
                            fullNameController.text.isNotEmpty) {
                      try {
                        print('enter thg escree ');
                        progress!.show();
                        if (image != null) {
                          var snapshot = await FirebaseStorage.instance
                              .ref()
                              .child(
                                  'AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
                              .putFile(image!);
                          liveImageURL = await snapshot.ref.getDownloadURL();
                        } else {
                          liveImageURL = '';
                        }
                        await FirebaseFirestore.instance
                            .collection('All_User_Details')
                            .doc(GetStorageServices.getToken())
                            .update({
                          'profile_image': liveImageURL,
                          'user_name': nameController.text.toString(),
                          'is_Profile_check': true,
                          'email': emailController!.text.isNotEmpty
                              ? emailController!.text.trim().toString()
                              : '',
                          'phone_no': mobileController!.text.isNotEmpty
                              ? mobileController!.text.trim().toString()
                              : '',
                          'full_name': fullNameController.text.toString(),
                        });

                        CommonMethod.setProfileAllDetails(
                            uid: await FirebaseAuth.instance.currentUser!.uid,
                            fullName: fullNameController.text.toString(),
                            email: emailController!.text.trim(),
                            mobile: mobileController!.text.trim(),
                            imageUrl: liveImageURL!,
                            name: nameController.text.toString());

                        progress.dismiss();

                        Get.offAll(BottomNavScreen());
                      } catch (e) {
                        progress!.dismiss();

                        return CommonWidget.getSnackBar(
                            message: 'went-wrong',
                            title: 'Failed',
                            duration: 2,
                            color: Colors.red);
                      }
                    } else {
                      CommonWidget.getSnackBar(
                          message: 'All fields are required',
                          title: 'Required',
                          duration: 2,
                          color: Colors.red);
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: themColors309D9D,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  imageUpload() async {
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(image!);
    liveImageURL = await snapshot.ref.getDownloadURL();
  }

  showDialogWidget() {
    return showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await imageFromGallery();
                      },
                      child: Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                            color: themColors309D9D,
                            borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Gallery',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await imageFromCamera();
                      },
                      child: Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                            color: themColors309D9D,
                            borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Camera',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ));
  }

  imageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickImage =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    setState(() {});
  }

  imageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickImage =
        await _picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    setState(() {});
  }
}
