import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/controller/favorite_counter.dart';
import 'package:my_ecomerce_app/controller/product_controller.dart';
import 'package:my_ecomerce_app/data/products.dart';

import 'package:my_ecomerce_app/widgets/btmnavbar.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favBag = ref.watch(favBagProvider);
    final product = ref.watch(proudctNotifierProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'My Favourite Page',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const BtmNavBar()));
              });
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: favBag.length,
                itemBuilder: (context, index) => Dismissible(
                  background: Container(
                    color: kSecondaryColor,
                    child: const Icon(Icons.delete_sweep_outlined),
                  ),
                  key: ValueKey<int>(favBag[index].pid),
                  onDismissed: (DismissDirection direction) {
                    ref.watch(proudctNotifierProvider.notifier).isSelectItem(
                          product[index].pid,
                          index,
                        );

                    // Remove the item from the shopping cart (itemBag)
                    ref
                        .watch(favBagProvider.notifier)
                        .removeItemfav(favBag[index].pid);

                    // If the product was selected, remove it again from the shopping cart
                    if (product[index].isSelected == true) {
                      ref
                          .read(favBagProvider.notifier)
                          .removeItemfav(product[index].pid);
                    }
                  },
                  child: Card(
                    child: Container(
                      height: screenHeight * 0.15,
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              productItems[index].imgUrl,
                              fit: BoxFit.cover,
                              height: screenHeight * 0.15,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productItems[index].title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(6),
                                  Text(
                                    productItems[index].shortDescription,
                                    style: AppTheme.kBodyText,
                                  ),
                                  const Gap(4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${productItems[index].price}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
