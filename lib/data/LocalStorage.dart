import 'package:get_storage/get_storage.dart';

class LocalStorage {
  GetStorage box = GetStorage();

  void saveToken(jwtToken, value) async {
    await box.write(jwtToken, value);
  }

  readToken() async {
    var token = await box.read("jwt");
    if (token == null) {
      token = "0";
    }
    return token;
  }

  Future deleteToken() async {
    box.remove('jwt');
  }
}
