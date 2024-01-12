import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/controller/itembag_controller.dart';
import 'package:my_ecomerce_app/controller/product_controller.dart';
import 'package:my_ecomerce_app/data/products.dart';
import 'package:gap/gap.dart';
import 'package:my_ecomerce_app/model/product_model.dart';

class HotSales extends ConsumerWidget {
  const HotSales({
    super.key,
    required this.productIndex,
  });
  final int productIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final product = ref.watch(proudctNotifierProvider);
    bool containsProduct(int productId) {
      return itemBag.any((item) => item.pid == productId);
    }

    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2),
        ],
      ),
      margin: const EdgeInsets.all(10),
      width: screenWidth * 0.41,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    product[productIndex].imgUrl,
                  ),
                ),
              ),
            ),
          ),
          const Gap(2),
          Text(
            product[productIndex].title,
            style: const TextStyle(
                color: kBlackColor, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Center(
            child: Text(product[productIndex].shortDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kLightBackground,
                )),
          ),
          const Gap(0.001),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                '\$${product[productIndex].price}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(),
              IconButton(
                onPressed: () {
                  ref
                      .read(proudctNotifierProvider.notifier)
                      .isSelectItem(product[productIndex].pid, productIndex);

                  // Only add the item to the itemBag once, even if the button is pressed multiple times.
                  if (product[productIndex].isSelected == false) {
                    ref.read(itemBagProvider.notifier).addItem(
                          ProductModel(
                            pid: product[productIndex].pid,
                            imgUrl: product[productIndex].imgUrl,
                            title: product[productIndex].title,
                            price: product[productIndex].price,
                            shortDescription:
                                product[productIndex].shortDescription,
                            longDescription:
                                product[productIndex].longDescription,
                            review: product[productIndex].review,
                            rating: product[productIndex].rating,
                          ),
                        );
                  } else {
                    ref
                        .read(itemBagProvider.notifier)
                        .removeItem(product[productIndex].pid);
                  }
                },
                icon: Icon(
                  product[productIndex].isSelected
                      ? Icons.check_circle
                      : Icons.add_circle,
                  size: 30,
                  color: kBlackColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
