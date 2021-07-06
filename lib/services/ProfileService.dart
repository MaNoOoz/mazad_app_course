import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mazad_app/helpers/Constants.dart';

import 'AuthService.dart';

class ProfileService {

  Future<List<dynamic>?> getAdsForUser(userId) async {
    var url = "$BaseUrl/Ads?user.id=$userId";
    var response = await http.get(Uri.parse("$url"), headers: headersNoAuth);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Logger().d("$data");

      return data;
    } else {
      Logger().d("Error Geting Data");
    }
  }
  Future<dynamic> deleteAd(adId) async {
    var url = "$BaseUrl/Ads/$adId";
    var userToken = await AuthService().getLoggedUserId();

    Map<String, String> headersAuth = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      "Authorization": "Bearer $userToken",
    };

    var response = await http.delete(Uri.parse("$url"), headers: headersAuth);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Logger().d("$data");

      return data;
    } else {
      Logger().d("Error Geting Data");
    }
  }
  // Future<List<dynamic>?> getCommentsForUser(userId) async {
  //   var url = "$BaseUrl/comments?user.id=$userId";
  //   var response = await http.get(Uri.parse("$url"), headers: headersNoAuth);
  //   final data = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     return data;
  //   } else {
  //     Logger().d("Error Geting Data");
  //   }
  // }
}
