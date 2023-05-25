import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:machinetest/controller/services/cart_service.dart';
import 'package:machinetest/main.dart';
import 'package:machinetest/model/product.dart';

class CartProvider extends ChangeNotifier {
  bool is_dbloading = false;
  List<Product> _product_list = [];
  List<Product> get product_list => _product_list;

  int _cart_count = 0;
  int get cart_count => _cart_count;
  final cart_service = CartService();
  bool is_cartloading = false;

  Future<void> getCartCount() async {
    is_dbloading = true;
    notifyListeners();
    _cart_count = await dbHelper.queryRowCount();
    is_dbloading = false;
    notifyListeners();
  }

  Future<void> addToCart(Product product, BuildContext context) async {
    is_dbloading = true;
    _product_list = [];
    is_cartloading = true;
    notifyListeners();
    final resp = await cart_service.addToCart(product);
    if (resp) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("added To Cart")));
      _cart_count = await dbHelper.queryRowCount();
      final resp = await dbHelper.getAllProducts();
      resp.map((e) => _product_list.add(Product.fromJsonForDb(e))).toList();
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error while adding To Cart")));
    }
    is_dbloading = false;
    is_cartloading = false;

    notifyListeners();
  }

  Future<void> removeFromCart(Product product, BuildContext context) async {
    is_dbloading = true;
    _product_list = [];
    is_cartloading = true;
    notifyListeners();
    final resp = await cart_service.removeFromCart(product);
    if (resp) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("removed item From Cart")));
      _cart_count = await dbHelper.queryRowCount();
      final resp = await dbHelper.getAllProducts();
      resp.map((e) => _product_list.add(Product.fromJsonForDb(e))).toList();
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error while adding To Cart")));
    }
    is_dbloading = false;
    is_cartloading = false;

    notifyListeners();
  }

  Future<void> cartFromDb() async {
    _product_list = [];
    is_cartloading = true;
    final resp = await dbHelper.getAllProducts();
    resp.map((e) => _product_list.add(Product.fromJsonForDb(e))).toList();
    print(product_list);
    is_cartloading = false;
    notifyListeners();
  }
}
