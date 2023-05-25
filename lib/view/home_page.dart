import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:machinetest/controller/provider/cart_provider.dart';
import 'package:machinetest/controller/provider/category_provider.dart';
import 'package:machinetest/controller/provider/product_provider.dart';
import 'package:machinetest/main.dart';
import 'package:machinetest/view/cart_page.dart';
import 'package:machinetest/view/category_product_page.dart';
import 'package:machinetest/view/product_details.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProvider>(context, listen: false).getCategoryList();
      Provider.of<ProductProvider>(context, listen: false).getProductList();
      Provider.of<CartProvider>(context, listen: false).getCartCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final product_data = Provider.of<ProductProvider>(context);
    final cart_data = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Icon(Icons.shopify_sharp),
            SizedBox(
              width: 10,
            ),
            Text("Fashion Hub"),
          ],
        )),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(child: AboutListTile()),
              ListTile(
                onTap: () => dbHelper.deletedb(),
                leading:
                    CircleAvatar(child: Icon(Icons.power_settings_new_sharp)),
                title: Text("Log Out"),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(currentIndex: 0, items: [
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Badge(
                  isLabelVisible: cart_data.cart_count > 0,
                  label: Text(cart_data.cart_count.toString()),
                  child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartPage(),
                          )),
                      child: Icon(Icons.shopping_cart))),
              label: 'Cart'),
        ]),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<CategoryProvider>(builder: (context, value, child) {
                  if (value.is_loading) {
                    return Shimmer.fromColors(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 244, 244, 244),
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.filter_list))
                                ],
                              ),
                            ),
                          ),
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 244, 244, 244),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Featured Categories",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.dashboard_customize_sharp))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Consumer<CategoryProvider>(builder: (context, value, child) {
                  if (value.is_loading) {
                    return Shimmer.fromColors(
                        child: Container(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!);
                  }
                  final list = value.category_list
                      .map((e) => InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CategoryProductPage(category_name: e),
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    child: Icon([
                                      Icons.shopping_bag_sharp,
                                      Icons.shopping_cart,
                                      Icons.store,
                                      Icons.storefront,
                                      Icons.card_giftcard_rounded,
                                      Icons.local_shipping,
                                      Icons.add_shopping_cart_outlined,
                                      Icons.shopify_sharp,
                                    ][Random().nextInt(8)]),
                                  ),
                                  Text(e)
                                ],
                              ),
                            ),
                          ))
                      .toList();
                  return Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: list,
                    ),
                  );
                }),
                Consumer<ProductProvider>(builder: (context, value, child) {
                  if (value.is_productloading) {
                    return Shimmer.fromColors(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 244, 244, 244),
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.filter_list))
                                ],
                              ),
                            ),
                          ),
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 244, 244, 244),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Featured Products",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                                onPressed: () {
                                  // showMenu(
                                  //     context: context,
                                  //     position: RelativeRect.fill,
                                  //     items: [
                                  //       PopupMenuItem(child: Text("iten"))
                                  //     ]);
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Wrap(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            'Filter Options',
                                            // style: Theme.of(context).textTheme.subtitle1
                                            //     .copyWith(
                                            //         color: theme
                                            //             .colorScheme.onPrimary),
                                          ),
                                          tileColor: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                        SwitchListTile(
                                          title: Text("Sort descending"),
                                          value: product_data.isascending,
                                          onChanged: (value) {
                                            product_data.getSorted(
                                                value, context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.filter_list))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Consumer<ProductProvider>(builder: (context, product, child) {
                  if (product.is_productloading) {
                    return Shimmer.fromColors(
                        child: GridView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(flex: 3, child: Text("")),
                                  Expanded(flex: 2, child: Text("")),
                                ],
                              ),
                            ),
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: .8),
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!);
                  }
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product_data.product_list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: .8),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          product: product_data.product_list[index],
                        ),
                      )),
                      child: Container(
                        // height: 500,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xffF4F4F4),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        product_data.product_list[index].image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      // width: (screenWidth * 0.53) - 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                    placeholder: (context, url) => SizedBox(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          product_data
                                              .product_list[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text(
                                            product_data
                                                .product_list[index].category,
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          children: [
                                            product_data.product_list[index]
                                                        .rating.rate >
                                                    0
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 3),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: 10,
                                                          color: product_data
                                                                      .product_list[
                                                                          index]
                                                                      .rating
                                                                      .rate >
                                                                  0
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Color.fromARGB(
                                                                  255,
                                                                  193,
                                                                  193,
                                                                  193),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 10,
                                                          color: product_data
                                                                      .product_list[
                                                                          index]
                                                                      .rating
                                                                      .rate >
                                                                  1
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Color.fromARGB(
                                                                  255,
                                                                  193,
                                                                  193,
                                                                  193),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 10,
                                                          color: product_data
                                                                      .product_list[
                                                                          index]
                                                                      .rating
                                                                      .rate >
                                                                  2
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Color.fromARGB(
                                                                  255,
                                                                  193,
                                                                  193,
                                                                  193),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 10,
                                                          color: product_data
                                                                      .product_list[
                                                                          index]
                                                                      .rating
                                                                      .rate >
                                                                  3
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Color.fromARGB(
                                                                  255,
                                                                  193,
                                                                  193,
                                                                  193),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 10,
                                                          color: product_data
                                                                      .product_list[
                                                                          index]
                                                                      .rating
                                                                      .rate >
                                                                  4
                                                              ? Theme.of(
                                                                      context)
                                                                  .primaryColor
                                                              : Color.fromARGB(
                                                                  255,
                                                                  193,
                                                                  193,
                                                                  193),
                                                        ),
                                                        // RichText(
                                                        //   text: TextSpan(
                                                        //     text: "${product!.rating} ",
                                                        //     style: Theme.of(context)
                                                        //         .textTheme
                                                        //         .caption!
                                                        //         .copyWith(fontSize: 11),
                                                        //     children: [
                                                        //       TextSpan(
                                                        //         text: '|',
                                                        //         style: Theme.of(context)
                                                        //             .textTheme
                                                        //             .caption!
                                                        //             .copyWith(fontSize: 11),
                                                        //       ),
                                                        //       TextSpan(
                                                        //         text:
                                                        //             ' ${product!.ratingCount} ${AppLocalizations.of(context)!.txt_ratings}',
                                                        //         style: Theme.of(context)
                                                        //             .textTheme
                                                        //             .caption!
                                                        //             .copyWith(fontSize: 11),
                                                        //       )
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Rs " +
                                                    product_data
                                                        .product_list[index]
                                                        .price
                                                        .toString(),
                                                // style: textTheme.bodyText1!.copyWith(
                                                //     fontWeight: FontWeight.bold,
                                                //     fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // InkWell(
                                              //   onTap: () async {},
                                              //   child: Container(
                                              //     decoration: BoxDecoration(
                                              //         // color: Theme.of(context)
                                              //         //     .primaryColor,
                                              //         color: Color.fromARGB(
                                              //             255, 236, 236, 236),
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //                 8)),
                                              //     alignment: Alignment.center,
                                              //     padding: EdgeInsets.all(8),
                                              //     child: Icon(
                                              //       Icons.favorite,
                                              //       size: 15.0,
                                              //       color: Theme.of(context)
                                              //           .primaryColor,
                                              //     ),
                                              //   ),
                                              // ),
                                              // SizedBox(
                                              //   width: 10,
                                              // ),
                                              InkWell(
                                                onTap: () async {
                                                  cart_data.addToCart(
                                                      product_data
                                                          .product_list[index],
                                                      context);
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .getCartCount();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      // color: Theme.of(context)
                                                      //     .primaryColor,
                                                      color: Color.fromARGB(
                                                          255, 236, 236, 236),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(8),
                                                  child: Icon(
                                                    Icons.shopping_cart_rounded,
                                                    size: 15.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        )));
  }
}
