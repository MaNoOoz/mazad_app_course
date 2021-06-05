import 'package:get/get.dart';
import 'package:mazad_app/models/Category.dart';
import 'package:mazad_app/services/Home%20Service.dart';

class HomeViewController extends GetxController {

  final homeService = HomeService();

  List<Category> _categories = <Category>[];

  List<Category> get categories => _categories;

  Future<List<Category>?> getCategoryList() async{
    try {
      homeService.getCategories().then((value) {
        _categories.clear();
        _categories =
            value!.map((element) => Category.fromJson(element)).toList();
      });
    } catch (e) {
      print(e);
    }
    return  categories ;
  }


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCategoryList();
  }
}
