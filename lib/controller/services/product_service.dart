import 'package:http/http.dart' as http;
import 'package:machinetest/config/conf.dart';
import 'package:machinetest/model/categroy.dart';
import 'package:machinetest/model/product.dart';

class ProductServices {
  Future<List<Product>> getCategoryProduct(String category) async {
    try {
      final response = await http
          .get(Uri.parse(Config().base_url + "products/category/$category"));
      print(Config().base_url + "products/category/$category");
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      } else {
        throw Exception("unable to get product");
      }
    } catch (e) {
      throw Exception("unable to get product");
    }
  }

  Future<List<Product>> getLimitedProduct(String limit) async {
    try {
      final response = await http
          .get(Uri.parse(Config().base_url + "products?limit=$limit"));
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      } else {
        throw Exception("unable to get product");
      }
    } catch (e) {
      throw Exception("unable to get product");
    }
  }

  Future<List<Product>> getproductInOrder({required bool is_ascending}) async {
    try {
      final response = await http.get(Uri.parse(
          Config().base_url + "products?sort=${is_ascending ? "" : "desc"}"));
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      } else {
        throw Exception("unable to get product");
      }
    } catch (e) {
      throw Exception("unable to get product");
    }
  }

  Future<List<Product>> getProductById(String id) async {
    try {
      final response = await http
          .get(Uri.parse(Config().base_url + "products/categories/$id"));
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      } else {
        throw Exception("unable to get product");
      }
    } catch (e) {
      throw Exception("unable to get product");
    }
  }
}
