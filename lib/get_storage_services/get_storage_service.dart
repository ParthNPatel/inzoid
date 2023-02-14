import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  static GetStorage getStorage = GetStorage();

  static setUserName({required String username}) {
    getStorage.write('username', username);
  }

  static getUserName() {
    return getStorage.read('username');
  }

  static setUserLoggedIn() {
    getStorage.write('isUserLoggedIn', true);
  }

  static getUserLoggedInStatus() {
    return getStorage.read('isUserLoggedIn');
  }

  /// user uid
  static setToken(String userUid) {
    getStorage.write('token', userUid);
  }

  static getToken() {
    return getStorage.read('token');
  }

  /// profile image
  static setProfileImageValue(String LoginValue) {
    getStorage.write('setProfileImage', LoginValue);
  }

  static getProfileImageValue() {
    return getStorage.read('setProfileImage');
  }

  /// name image
  static setNameValue(String LoginValue) {
    getStorage.write('setNameValue', LoginValue);
  }

  static getNameValue() {
    return getStorage.read('setNameValue');
  }

  /// full name
  static setFullNameValue(String LoginValue) {
    getStorage.write('setFullNameValue', LoginValue);
  }

  static getFullNameValue() {
    return getStorage.read('setFullNameValue');
  }

  /// email
  static setEmail(String LoginValue) {
    getStorage.write('setEmailValue', LoginValue);
  }

  static getEmail() {
    return getStorage.read('setEmailValue');
  }

  /// mobile
  static setMobile(String LoginValue) {
    getStorage.write('setMobile', LoginValue);
  }

  static getMobile() {
    return getStorage.read('setMobile');
  }

  /// is Email or phone
  static setIsEmailOrPhone(bool LoginValue) {
    getStorage.write('setIsEmailOrPhone', LoginValue);
  }

  static getIsEmailOrPhone() {
    return getStorage.read('setIsEmailOrPhone');
  }

  /// fcm token
  static setFcmToken(String fcmToken) {
    getStorage.write('fcmToken', fcmToken);
  }

  static getFcmToken() {
    return getStorage.read('fcmToken');
  }

  /// StartPrice
  static setStart(int start) {
    getStorage.write('start', start);
  }

  static getStart() {
    return getStorage.read('start');
  }

  /// End price
  static setEnd(int end) {
    getStorage.write('end', end);
  }

  static getEnd() {
    return getStorage.read('end');
  }

  /// COLOR
  static setColor(Map color) {
    getStorage.write('color', color);
  }

  static getColor() {
    return getStorage.read('color');
  }

  /// COLOR
  static setMaterial(Map material) {
    getStorage.write('material', material);
  }

  static getMaterial() {
    return getStorage.read('material');
  }

  /// SEASON
  static setSeason(Map season) {
    getStorage.write('season', season);
  }

  static getSeason() {
    return getStorage.read('season');
  }

  /// SEASON
  static setSize(Map size) {
    getStorage.write('size', size);
  }

  static getSize() {
    return getStorage.read('size');
  }

  static logOut() {
    getStorage.remove('setIsEmailOrPhone');
    getStorage.remove('setMobile');
    getStorage.remove('setEmailValue');
    getStorage.remove('setNameValue');
    getStorage.remove('setProfileImage');
    getStorage.remove('username');
    getStorage.remove('isUserLoggedIn');
    getStorage.remove('setFullNameValue');
    getStorage.remove('start');
    getStorage.remove('end');
    getStorage.remove('color');
    getStorage.remove('season');
    getStorage.remove('size');
  }
}
