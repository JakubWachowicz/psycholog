import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/storage.dart';

import '../../entities/user.dart';
import '../services/storage.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();


  final _isLogin = false.obs;

  String token = '';
  String role = '';

  final _profile = UserLoginResponseEntity().obs;

  bool get isLogin => _isLogin.value;
  UserLoginResponseEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    role = StorageService.to.getString(STORAGE_USER_ROLE_KEY);

    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    }
  }


  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  Future<void> setRole(String value) async {
    await StorageService.to.setString(STORAGE_USER_ROLE_KEY, value);
    role = value;
  }

  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    // var result = await UserAPI.profile();
    // _profile(result);
    // _isLogin.value = true;
    return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    setToken(profile.accessToken!);
  }


  Future<void> onLogout() async {
    // if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
    role = '';
  }
}
