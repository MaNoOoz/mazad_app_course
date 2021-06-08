import 'package:get/get.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/services/ProfileService.dart';

class ProfileController extends GetxController {

  final profileService = ProfileService();

  List<Ad> _Ads = <Ad>[];


  List<Ad> get Ads => _Ads;

  set Ads(List<Ad> value) {
    _Ads = value;
  }

  int userId = 4;

  // get User Ads
  Future<List<Ad>?> getAdsListForUser(int userId) async {
    print("getAdsListWithFilter ");

    try {
      await profileService.getAdsForUser(userId).then((value) {
        _Ads.clear();

        _Ads = value!.map((element) => Ad.fromJson(element)).toList();
        _Ads.forEach((Ad element) {
          print("${element.title}");
        });
        print("FILTER LIST ${_Ads.length}");
      });
    } catch (e) {
      print(e);
    }
    update();

    return _Ads;
  }



}
