import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mazad_app/controllers/AuthController/LoginController.dart';
import 'package:mazad_app/models/Ad.dart';
import 'package:mazad_app/services/ProfileService.dart';

class ProfileController extends GetxController {
  final profileService = ProfileService();

  List<Ad> adList = <Ad>[];
  List<Comment> commentList = <Comment>[];

  // int userId = 4;
  User? user = User();

  Future<List<Ad>?> getAdsListForUser() async {
    Logger().d("getAdsListForUser ");
    user = await Get.find<LoginController>().getLoggedInUserObject();

    var userId = user!.id!;
    Logger().d(userId.toString());

    try {
      await profileService.getAdsForUser(userId).then((value) {
        adList.clear();

        adList = value!.map((element) => Ad.fromJson(element)).toList();
        adList.forEach((Ad element) {
          // Logger().d("${element.title}");
        });
        // Logger().d("FILTER LIST ${_Ads.length}");
      });
    } catch (e) {
      Logger().d(e);
    }
    update();

    return adList;
  }

  Future deleteAd(int adId) async {
    Logger().d("deleteAd ");

    try {
      await profileService.deleteAd(adId).then((value) {
        adList.removeWhere((element) => element.id == adId);
        Logger().d(adList);
        update();

        var a = Ad.fromJson(value);
        Logger().d(a);
      });
    } catch (e) {
      Logger().d(e);
    }
    update();

    return adList;
  }

  // Future<List<Comment>?> getCommentsForUser(int userId) async {
  //   Logger().d("getCommentsForUser ");
  //   userId = user!.id!;
  //   Logger().d(user!.id);
  //
  //   try {
  //     await profileService.getCommentsForUser(userId).then((value) {
  //       commentList.clear();
  //
  //       commentList = value!.map((element) => Comment.fromJson(element)).toList();
  //       commentList.forEach((Comment element) {
  //         Logger().d(" hi : ${element.commentText!}");
  //       });
  //       // Logger().d("FILTER LIST ${_Ads.length}");
  //     });
  //   } catch (e) {
  //     Logger().d(e);
  //   }
  //   update();
  //
  //   return commentList;
  // }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAdsListForUser();
    // await getCommentsForUser(userId);
  }
}
