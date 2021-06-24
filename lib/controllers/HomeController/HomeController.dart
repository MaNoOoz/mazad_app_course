import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/models/Ad.dart' show Ad,Category;
// import 'package:mazad_app/models/Category.dart';
import 'package:mazad_app/services/Home%20Service.dart';
import 'package:mazad_app/utils/app_state.dart';

class HomeViewController extends GetxController with SingleGetTickerProviderMixin{
  final homeService = HomeService();

  List<Category> _categories = <Category>[];
  List<Ad> _adList = <Ad>[];
  List<Ad> _adsListFilter = <Ad>[];

  int catId = 2;
  var likes = 0.obs;
  final appState = Rx<AppState>(AppState.LOADING);

  increment() => likes++;

  List<Category> get categories => _categories;

  List<Ad> get ads => _adList;

  List<Ad> get adsListFilter => _adsListFilter;

  Future<List<Category>?> getCategoryList() async {
    try {
      homeService.getCategories().then((value) {
        // _categories.clear();
        _categories =
            value!.map((element) => Category.fromJson(element)).toList();
      });
    } catch (e) {
      Logger().d(e);
    }
    update();

    return categories;
  }


  Future<List<Ad>?> getAdsListWithFilter(int catId) async {
    Logger().d("getAdsListWithFilter ");

    appState.value = AppState.LOADING;
    try {
      await homeService.getAdsWithFilter(catId).then((value) {
        _adsListFilter.clear();

        _adsListFilter = value!.map((element) => Ad.fromJson(element)).toList();
        _adsListFilter.forEach((Ad element) {
          // Logger().d("${element.adImages!.length}");
        });
        Logger().d("FILTER LIST ${adsListFilter.length}");
        // var imageList = _adsListFilter!.map((e) => e.adImages!.map((e) => e!.url)).toList();
        // Logger().d(imageList.runtimeType);
        // if(_Ads!.map((e) => e.adImages!.length) == null){
        // Logger().d('Hi ${adImages!.length.toString()}');
        // }
      });
      appState.value = AppState.DONE;
      update();

    } catch (e) {
      Logger().d(e);
    }

    return adsListFilter;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await getCategoryList();
    await getAdsListWithFilter(catId);

    appState.value = AppState.DONE;

  }
}
