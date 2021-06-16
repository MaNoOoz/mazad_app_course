import 'package:get/get.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/services/ProfileService.dart';

class ProfileController extends GetxController {
  final profileService = ProfileService();

  List<Ad> adList = <Ad>[];

  int userId = 4;
  User? user = User();

  Future<List<Ad>?> getAdsListForUser(int userId) async {
    print("getAdsListForUser ");
    userId = user!.id!;
    print(user!.id);

    try {
      await profileService.getAdsForUser(userId).then((value) {
        adList.clear();

        adList = value!.map((element) => Ad.fromJson(element)).toList();
        adList.forEach((Ad element) {
          // print("${element.title}");
        });
        // print("FILTER LIST ${_Ads.length}");
      });
    } catch (e) {
      print(e);
    }
    update();

    return adList;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    user = await Get.find<LoginController>().getUser();
    await getAdsListForUser(userId);
  }
}
