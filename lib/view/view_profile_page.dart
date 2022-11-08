import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inzoid/components/common_method.dart';
import 'package:inzoid/constant/text_styel.dart';
import '../components/common_widget.dart';
import '../constant/color_const.dart';
import '../get_storage_services/get_storage_service.dart';
import 'bottom_bar_screen.dart';
import 'my_wish_list_page.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ViewProfilePageState();
  }
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  TextEditingController? nameController;
  TextEditingController? fullNameController;
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
    nameController =
        TextEditingController(text: GetStorageServices.getNameValue());
    fullNameController =
        TextEditingController(text: GetStorageServices.getFullNameValue());
    emailController =
        TextEditingController(text: GetStorageServices.getEmail());
    mobileController =
        TextEditingController(text: GetStorageServices.getMobile());

    liveImageURL = GetStorageServices.getProfileImageValue() == null ||
            GetStorageServices.getProfileImageValue() == ''
        ? ''
        : GetStorageServices.getProfileImageValue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.7,
            leading: bacButtonWidget(),
            centerTitle: true,
            title: CommonText.textBoldWight700(
                text: 'My Profile', color: Colors.black),
          ),
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
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5)),
                  child: showImageWidget(),
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
                  child: TextFormField(
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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

  showImageWidget() {
    try {
      return image == null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Image.network(
                '${GetStorageServices.getProfileImageValue()}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  color: Colors.grey,
                  Icons.person,
                  size: 120,
                ),
              ))
          : ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Image.file(
                image!,
                fit: BoxFit.cover,
              ));
    } catch (e) {
      return Icon(
        color: Colors.grey,
        Icons.person,
        size: 120,
      );
    }
  }
}
