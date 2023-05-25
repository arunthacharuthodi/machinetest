import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:machinetest/controller/provider/cart_provider.dart';
import 'package:machinetest/controller/provider/product_provider.dart';
import 'package:machinetest/view/product_details.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryProductPage extends StatefulWidget {
  String category_name;
  CategoryProductPage({required this.category_name});

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print(widget.category_name);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false)
          .getCateoryProduct(widget.category_name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart_data = Provider.of<CartProvider>(context);

    final product_data = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category_name),
        ),
        body: !product_data.is_categoryproductloading
            ? GridView.builder(
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: product_data.category_product_list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .8),
                itemBuilder: (context, index) {
                  // if (product_data.is_categoryproductloading) {
                  //   return Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetails(
                        product: product_data.category_product_list[index],
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
                                  imageUrl: product_data
                                      .category_product_list[index].image,
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
                                          child: CircularProgressIndicator())),
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
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                        product_data
                                            .category_product_list[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Text(
                                          product_data
                                              .category_product_list[index]
                                              .category,
                                          style: TextStyle(fontSize: 12)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        children: [
                                          product_data
                                                      .category_product_list[
                                                          index]
                                                      .rating
                                                      .rate >
                                                  0
                                              ? Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 3),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        size: 10,
                                                        color: product_data
                                                                    .category_product_list[
                                                                        index]
                                                                    .rating
                                                                    .rate >
                                                                0
                                                            ? Theme.of(context)
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
                                                                    .category_product_list[
                                                                        index]
                                                                    .rating
                                                                    .rate >
                                                                1
                                                            ? Theme.of(context)
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
                                                                    .category_product_list[
                                                                        index]
                                                                    .rating
                                                                    .rate >
                                                                2
                                                            ? Theme.of(context)
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
                                                                    .category_product_list[
                                                                        index]
                                                                    .rating
                                                                    .rate >
                                                                3
                                                            ? Theme.of(context)
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
                                                                    .category_product_list[
                                                                        index]
                                                                    .rating
                                                                    .rate >
                                                                4
                                                            ? Theme.of(context)
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
                                                      .category_product_list[
                                                          index]
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
                                            InkWell(
                                              onTap: () async {
                                                cart_data.addToCart(
                                                    product_data
                                                        .product_list[index],
                                                    context);
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
                  );
                })
            : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: .8),
                    itemBuilder: (context, index) {
                      // if (product_data.is_categoryproductloading) {
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // }
                      return Container(
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
                                          "",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Text("",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.star,
                                                      size: 10,
                                                      color: Theme.of(context)
                                                          .primaryColor),

                                                  Icon(Icons.star,
                                                      size: 10,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  Icon(Icons.star,
                                                      size: 10,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  Icon(Icons.star,
                                                      size: 10,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  Icon(Icons.star,
                                                      size: 10,
                                                      color: Theme.of(context)
                                                          .primaryColor),
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
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(""
                                                  // style: textTheme.bodyText1!.copyWith(
                                                  //     fontWeight: FontWeight.bold,
                                                  //     fontSize: 14),
                                                  ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {},
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
                                                    Icons.favorite,
                                                    size: 15.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {},
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
                      );
                    })));
  }
}
