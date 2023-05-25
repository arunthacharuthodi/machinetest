import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:machinetest/config/conf.dart';
import 'package:machinetest/model/categroy.dart';

class CategoryService {
  Future<List<String>> getCategoryList() async {
    try {
      final response =
          await http.get(Uri.parse(Config().base_url + "products/categories"));
      if (response.statusCode == 200) {
        return categoryFromJson(response.body);
      } else {
        throw Exception("unable to get category");
      }
    } catch (e) {
      throw Exception("unable to get category");
    }
  }
}
