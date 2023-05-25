import 'package:flutter/material.dart';
import 'package:machinetest/controller/provider/cart_provider.dart';
import 'package:machinetest/controller/provider/category_provider.dart';
import 'package:machinetest/controller/provider/product_provider.dart';
import 'package:machinetest/controller/services/product_service.dart';
import 'package:machinetest/helper/db.dart';
import 'package:machinetest/view/home_page.dart';
import 'package:provider/provider.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fashion store',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Lato',

        textTheme: const TextTheme(
          // bodySmall: TextStyle(fontSize: 12),
          // bodyMedium: TextStyle(fontSize: 12),
          // titleSmall: TextStyle(fontSize: 12),
          // titleMedium: TextStyle(fontSize: 18),
          titleLarge:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xffE08831)),
          bodyMedium: TextStyle(
              fontFamily: 'Signika',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            // color: Color(0xffE08831),
            centerTitle: false,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )),
        useMaterial3: true,
        // primarySwatch: C,
      ),
      home: const HomePage(),
    );
  }
}
