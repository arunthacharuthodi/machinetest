import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:machinetest/controller/provider/cart_provider.dart';
import 'package:machinetest/controller/provider/product_provider.dart';
import 'package:machinetest/model/product.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  Product product;
  ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final product_data = Provider.of<ProductProvider>(context);
    final cart_data = Provider.of<CartProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Product Details"),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.8,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          widget.product.title,
                          style: TextStyle(
                              fontFamily: 'Signika',
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        widget.product.rating.rate > 0
                            ? Row(
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
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: widget.product.rating.rate > 0
                                              ? Theme.of(context).primaryColor
                                              : Color.fromARGB(
                                                  255, 193, 193, 193),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: widget.product.rating.rate > 1
                                              ? Theme.of(context).primaryColor
                                              : Color.fromARGB(
                                                  255, 193, 193, 193),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: widget.product.rating.rate > 2
                                              ? Theme.of(context).primaryColor
                                              : Color.fromARGB(
                                                  255, 193, 193, 193),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: widget.product.rating.rate > 3
                                              ? Theme.of(context).primaryColor
                                              : Color.fromARGB(
                                                  255, 193, 193, 193),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: widget.product.rating.rate > 4
                                              ? Theme.of(context).primaryColor
                                              : Color.fromARGB(
                                                  255, 193, 193, 193),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                "${widget.product.rating.count} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 11),
                                            children: [
                                              TextSpan(
                                                text: '|',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(fontSize: 11),
                                              ),
                                              TextSpan(
                                                text: ' Rating',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(fontSize: 11),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Container(
                          child: Text(
                            widget.product.category,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Rs " + widget.product.price.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 222, 189),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      widget.product.description,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () async {
                    cart_data.addToCart(widget.product, context);
                    Provider.of<CartProvider>(context, listen: false)
                        .getCartCount();
                  },
                  child: Text("Add To Cart")),
            ),
          )
        ],
      ),
    );
  }
}
