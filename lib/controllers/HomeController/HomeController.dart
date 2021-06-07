import 'package:get/get.dart';
import 'package:mazad_app/models/Ad.dart' show Ad;
import 'package:mazad_app/models/Category.dart';
import 'package:mazad_app/services/Home%20Service.dart';

class HomeViewController extends GetxController {
  final homeService = HomeService();

  List<Category> _categories = <Category>[];
  List<Ad> _Ads = <Ad>[];
  List<Ad> _adsListFilter = <Ad>[];

  int catId = 0;
  var likes = 0.obs;
  increment() => likes++;
  List<Category> get categories => _categories;

  List<Ad> get Ads => _Ads;

  List<Ad> get adsListFilter => _adsListFilter;

  Future<List<Category>?> getCategoryList() async {
    try {
      homeService.getCategories().then((value) {
        _categories.clear();
        _categories =
            value!.map((element) => Category.fromJson(element)).toList();
      });
    } catch (e) {
      print(e);
    }
    update();

    return categories;
  }

  Future<List<Ad>?> getAdsList() async {
    try {
      homeService.getAds().then((value) {
        _Ads.clear();
        _Ads = value!.map((element) => Ad.fromJson(element)).toList();

        // _Ads.addAll(_Ads);
      });
    } catch (e) {
      print(e);
    }
    update();

    return Ads;
  }

  Future<List<Ad>?> getAdsListWithFilter(int catId) async {
    print("getAdsListWithFilter ");

    try {
      await homeService.getAds2(catId).then((value) {
        _adsListFilter.clear();

        _adsListFilter = value!.map((element) => Ad.fromJson(element)).toList();
        _adsListFilter.forEach((Ad element) {
          print("${element.title}");
        });
        print("FILTER LIST ${adsListFilter.length}");
      });
    } catch (e) {
      print(e);
    }
    update();

    return adsListFilter;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCategoryList();
    await getAdsList();
    await getAdsListWithFilter(catId);
  }
}
