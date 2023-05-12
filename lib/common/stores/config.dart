
import 'dart:ui';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../services/storage.dart';
class ConfigStore extends GetxController{

  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;
  PackageInfo? _platform;
  String get version => _platform?.version ?? '-';
  bool get isRelease => bool.fromEnvironment("dart.vm.product");
  Locale locale = Locale('en','US');
  List<Locale> languages = [
    Locale('en', 'US'),
    Locale('pl','PL'),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isFirstOpen = StorageService.to.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
  }

  Future<void> getPlatforms() async {
    _platform = await PackageInfo.fromPlatform();
  }
  Future<bool> saveAlreadyOpen(){
    return StorageService.to.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY,true);

  }

  void onInitLocale(){
    var langCode = StorageService.to.getString(STORAGE_LANGUAGE_CODE);

  }




}