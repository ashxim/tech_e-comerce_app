import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/controller/itembag_controller.dart';
import 'package:my_ecomerce_app/controller/product_controller.dart';

import 'package:my_ecomerce_app/widgets/btmnavbar.dart';

class CartPage extends ConsumerWidget {
  CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemBag = ref.watch(itemBagProvider);
    final product = ref.watch(proudctNotifierProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'My Cart',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: itemBag.length,
                itemBuilder: (context, index) => Dismissible(
                  background: Container(
                    color: kSecondaryColor,
                    child: const Icon(Icons.delete_sweep_outlined),
                  ),
                  key: ValueKey<int>(itemBag[index].pid),
                  onDismissed: (DismissDirection direction) {
                    ref.watch(proudctNotifierProvider.notifier).isSelectItem(
                          product[index].pid,
                          index,
                        );

                    // Remove the item from the shopping cart (itemBag)
                    ref
                        .watch(itemBagProvider.notifier)
                        .removeItem(itemBag[index].pid);

                    // If the product was selected, remove it again from the shopping cart
                    if (product[index].isSelected == true) {
                      ref
                          .read(itemBagProvider.notifier)
                          .removeItem(product[index].pid);
                    }
                    Icon(
                      product[index].isSelected
                          ? Icons.check_circle
                          : Icons.add_circle,
                      size: 30,
                      color: kBlackColor,
                    );
                  },
                  child: Card(
                    child: Container(
                      height: screenHeight * 0.17,
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              itemBag[index].imgUrl,
                              height: screenHeight * 0.18,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    itemBag[index].title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    itemBag[index].shortDescription,
                                    style: AppTheme.kBodyText,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${itemBag[index].price * itemBag[index].qty}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.07,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(itemBagProvider
                                                        .notifier)
                                                    .decreaseQty(
                                                        itemBag[index].pid);
                                              },
                                              icon: const Icon(Icons
                                                  .do_disturb_on_outlined)),
                                          Text(
                                            itemBag[index].qty.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(itemBagProvider
                                                        .notifier)
                                                    .incrementQty(
                                                        itemBag[index].pid);
                                              },
                                              icon: const Icon(Icons
                                                  .add_circle_outline_sharp)),
                                        ],
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
          ),
          const Divider(
            height: 1, // Set the height to a non-zero value
            endIndent: 30,
            indent: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SubTotal :',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${ref.watch(itemBagProvider.notifier).total}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'No discount',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee :',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'free',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    height: 5, // Set the height to a non-zero value
                    endIndent: 30,
                    indent: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total :',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor),
                      ),
                      Text(
                        '\$${ref.watch(itemBagProvider.notifier).total}',
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Continue to Checkout',
                      style: TextStyle(color: kWhiteColor, fontSize: 24),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      fixedSize: const Size(350, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
