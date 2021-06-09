




import 'dart:convert';

import 'package:mazad_app/helpers/Constants.dart';
import 'package:http/http.dart' as http;

class ProfileService {

  Future<List<dynamic>?> getAdsForUser(userId) async {
    var url = "$BaseUrl/Ads?user.id=$userId";
    var response = await http.get(Uri.parse("$url"), headers: headersNoAuth);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {

      return data;
    }else{
      print("Error Geting Data");
    }
  }


}
