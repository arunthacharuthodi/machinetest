import 'package:flutter/material.dart';
import 'package:machinetest/controller/services/category_services.dart';

class CategoryProvider extends ChangeNotifier {
  final catergory_service = CategoryService();
  List<String> category_list = [];
  bool is_loading = false;
  Future<void> getCategoryList() async {
    is_loading = true;
    notifyListeners();
    category_list = await catergory_service.getCategoryList();
    is_loading = false;
    notifyListeners();
  }
}
