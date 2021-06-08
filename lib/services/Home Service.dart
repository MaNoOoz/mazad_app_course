import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mazad_app/helpers/Constants.dart';

class HomeService {


  Future<List<dynamic>?> getCategories() async {
    var url = "$BaseUrl/categories";
    var response = await http.get(Uri.parse("$url"), headers: headersNoAuth);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);

      return data;
    }else{
      print("Error Geting Data");
    }
  }
  Future<List<dynamic>?> getAds() async {
    var url = "$BaseUrl/ads";
    var response = await http.get(Uri.parse("$url"), headers: headersNoAuth);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print(data);

      return data;
    }else{
      print("Error Geting Data");
    }
  }
  Future<List<dynamic>?> getAdsWithFilter(catId) async {
    var url = "$BaseUrl/Ads?category.id=$catId";
    var response = await http.get(Uri.parse("$url"), headers: headersNoAuth);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print(data);

      return data;
    }else{
      print("Error Geting Data");
    }
  }
  Future<List<dynamic>?> getAdsForUser(userId) async {
    var url = "$BaseUrl/Ads?user.id=$userId";
    var response = await http.get(Uri.parse("$url"), headers: headersNoAuth);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print(data);

      return data;
    }else{
      print("Error Geting Data");
    }
  }


}
