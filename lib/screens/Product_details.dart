import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/controller/favorite_counter.dart';
import 'package:my_ecomerce_app/controller/itembag_controller.dart';
import 'package:my_ecomerce_app/data/products.dart';
import 'package:my_ecomerce_app/controller/product_controller.dart';

import 'package:my_ecomerce_app/model/product_model.dart';
import 'package:my_ecomerce_app/screens/cart_page.dart';

class ProductDetails extends ConsumerWidget {
  ProductDetails({
    required this.getIndex, // Optional with a default value of 1

    super.key,
  });

  int getIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final favbag = ref.watch(favBagProvider);
    final product = ref.watch(proudctNotifierProvider);
    final itemBag = ref.watch(itemBagProvider);
    bool containsFavBag(int productId) {
      return itemBag.any((item) => item.pid == productId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // This line will pop the current screen.
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
                icon: Badge(
                  label: Text(itemBag.length.toString()),
                  alignment: Alignment.topRight,
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 6),
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              height: screenHeight * 0.4,
              width: double.maxFinite,
              child: Image.asset(
                productItems[getIndex].imgUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      productItems[getIndex].title,
                      style: const TextStyle(
                        fontSize: 30,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar(
                        onRatingUpdate: (value) => null,
                        ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                          ),
                          half: const Icon(
                            Icons.star_half_outlined,
                            color: Colors.amberAccent,
                          ),
                          empty: const Icon(Icons.star_border),
                        ),
                        maxRating: 5,
                        minRating: 1,
                        allowHalfRating: true,
                        initialRating: product[getIndex].rating,
                        itemSize: 15,
                      ),
                      const SizedBox(width: 5),
                      const Text('|'),
                      const SizedBox(width: 5),
                      Text(product[getIndex].review.toString()),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product[getIndex].longDescription,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product[getIndex].price * product[getIndex].qty}',
                        style: const TextStyle(
                          fontSize: 25,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(proudctNotifierProvider.notifier)
                                  .decreaseQty(product[getIndex].pid);
                            },
                            icon: const Icon(Icons.do_disturb_on_outlined),
                            iconSize: 30,
                          ),
                          Text(
                            product[getIndex].qty.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(proudctNotifierProvider.notifier)
                                  .incrementQty(product[getIndex].pid);
                            },
                            icon: const Icon(Icons.add_circle_outline_sharp),
                            iconSize: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          minimumSize: Size(screenWidth * 0.8, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          final proudctNotifier =
                              ref.read(proudctNotifierProvider.notifier);

                          // Set the selected state of the product
                          proudctNotifier.isSelectItem(
                              product[getIndex].pid, getIndex);

                          // If the product is not selected, add it to the item bag
                          if (product[getIndex].isSelected == false) {
                            ref.read(itemBagProvider.notifier).addItem(
                                  ProductModel(
                                      pid: product[getIndex].pid,
                                      imgUrl: product[getIndex].imgUrl,
                                      title: product[getIndex].title,
                                      price: product[getIndex].price,
                                      shortDescription:
                                          product[getIndex].shortDescription,
                                      longDescription:
                                          product[getIndex].longDescription,
                                      review: product[getIndex].review,
                                      rating: product[getIndex].rating),
                                );
                          } else {
                            ref
                                .read(itemBagProvider.notifier)
                                .removeItem(product[getIndex].pid);
                          }
                        },
                        child: const Text(
                          'Add item to bag',
                          style: TextStyle(color: kWhiteColor, fontSize: 20),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kSecondaryColor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            final favBagNotifier =
                                ref.watch(favBagProvider.notifier);

                            // Toggle the favorite state of the product
                            favBagNotifier.toggleFavorite(
                                product[getIndex].pid, getIndex);

                            // If the product is not selected, add it to the favorite bag
                            if (product[getIndex].isSelected == false) {
                              favBagNotifier.addItemfav(
                                ProductModel(
                                  pid: product[getIndex].pid,
                                  imgUrl: product[getIndex].imgUrl,
                                  title: product[getIndex].title,
                                  price: product[getIndex].price,
                                  shortDescription:
                                      product[getIndex].shortDescription,
                                  longDescription:
                                      product[getIndex].longDescription,
                                  review: product[getIndex].review,
                                  rating: product[getIndex].rating,
                                ),
                                getIndex,
                              );
                            } else {
                              // If the product is selected, remove it from the favorite bag
                              favBagNotifier
                                  .removeItemfav(favbag[getIndex].pid);
                            }
                          },
                          icon: Icon(
                            product[getIndex].isSelected
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 30,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
