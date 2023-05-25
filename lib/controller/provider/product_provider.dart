import 'package:flutter/material.dart';
import 'package:machinetest/controller/services/category_services.dart';
import 'package:machinetest/controller/services/product_service.dart';
import 'package:machinetest/model/product.dart';

class ProductProvider extends ChangeNotifier {
  final product_service = ProductServices();
  List<Product> _product_list = [];
  List<Product> _category_product_list = [];

  List<Product> get product_list => _product_list;
  List<Product> get category_product_list => _category_product_list;
  bool is_productloading = false;
  bool is_categoryproductloading = false;

  bool _isaccending = true;
  bool get isascending => _isaccending;

  Future<void> getProductList() async {
    is_productloading = true;
    notifyListeners();
    _product_list = await product_service.getLimitedProduct("10");
    is_productloading = false;
    notifyListeners();
  }

  Future<void> getSorted(bool is_ascending, BuildContext context) async {
    _isaccending = is_ascending;
    is_productloading = true;
    notifyListeners();
    Navigator.pop(context);
    _product_list =
        await product_service.getproductInOrder(is_ascending: is_ascending);
    is_productloading = false;
    notifyListeners();
  }

  Future<void> getCateoryProduct(String Category) async {
    is_categoryproductloading = true;
    notifyListeners();
    _category_product_list = await product_service.getCategoryProduct(Category);
    is_categoryproductloading = false;
    notifyListeners();
  }
}
