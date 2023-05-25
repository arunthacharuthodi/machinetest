import 'dart:convert';

import 'package:machinetest/helper/db.dart';
import 'package:machinetest/main.dart';
import 'package:machinetest/model/product.dart';

class CartService {
  Future<bool> addToCart(Product product) async {
    try {
      final json = product.toJson();
      json.addAll({"count": 1});
      final resp = dbHelper.addToCart(json);
      print(resp);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromCart(Product product) async {
    try {
      // final json = product.toJson();
      // json.addAll({"count": 1});
      final resp = dbHelper.removeFromCart(product.id);
      print(resp);
      return true;
    } catch (e) {
      return false;
    }
  }
}
