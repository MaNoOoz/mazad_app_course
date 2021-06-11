import 'package:get/get.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/services/ProfileService.dart';

class ProfileController extends GetxController {
  final profileService = ProfileService();

  List<Ad> _adList = <Ad>[];

  int userId = 4;

  List<Ad> get adList => _adList; // get User Ads
  Future<List<Ad>?> getAdsListForUser(int userId) async {
    print("getAdsListForUser ");
    LoginController s = LoginController();
    var user = await s.getUser();
    userId = user!.id;
    // print(user.id);

    try {
      await profileService.getAdsForUser(userId).then((value) {
        _adList.clear();

        _adList = value!.map((element) => Ad.fromJson(element)).toList();
        _adList.forEach((Ad element) {
          // print("${element.title}");
        });
        // print("FILTER LIST ${_Ads.length}");
      });
    } catch (e) {
      print(e);
    }
    update();

    return _adList;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAdsListForUser(userId);
  }
}
