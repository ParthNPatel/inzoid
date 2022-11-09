import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inzoid/view/bottom_bar_screen.dart';

import '../get_storage_services/get_storage_service.dart';
import '../view/set_profile_screen.dart';

class CommonMethod {
  static likeFiledAdd(BuildContext context, {bool? isEmail}) async {
    print('grehgrehgdrhd   ${GetStorageServices.getToken()}');
    final equipmentCollection = FirebaseFirestore.instance
        .collection("All_User_Details")
        .doc(GetStorageServices.getToken());

    final docSnap = await equipmentCollection.get();
    List queue;
    try {
      queue = docSnap.get('list_of_like');
      print('queue update app    ${queue}');
      try {
        var getDoc = FirebaseFirestore.instance
            .collection('All_User_Details')
            .doc(GetStorageServices.getToken());
        var fetchData = await getDoc.get();
        setProfileAllDetails(
          uid: FirebaseAuth.instance.currentUser!.uid,
          fullName: fetchData['full_name'],
          imageUrl: fetchData['profile_image'],
          name: fetchData['user_name'],
          email: fetchData['email'],
          mobile: fetchData['phone_no'],
        );
        log("Heyyyyy");
        Get.off(BottomNavScreen());
      } catch (e) {
        log("Heyyyyy1111111111");
        Get.off(SetProfileScreen());
      }
    } catch (e) {
      try {
        log("Heyyyyy222");
        await FirebaseFirestore.instance
            .collection("All_User_Details")
            .doc(GetStorageServices.getToken())
            .set({
          "list_of_like": [],
          'profile_image': '',
          'user_name': '',
          'is_Profile_check': true
        });
        Get.off(SetProfileScreen());
      } catch (e) {
        print('ERROR IN lIKE NULL LIST');
      }
    }
  }

  static setProfileAllDetails({
    required String imageUrl,
    required String name,
    required String fullName,
    required String email,
    required String mobile,
    required String uid,
  }) {
    GetStorageServices.setUserLoggedIn();
    GetStorageServices.setToken(uid);
    GetStorageServices.setProfileImageValue(imageUrl);
    GetStorageServices.setNameValue(name);
    GetStorageServices.setFullNameValue(fullName);
    GetStorageServices.setEmail(email);
    GetStorageServices.setMobile(mobile);
  }
}
