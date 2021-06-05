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


}
