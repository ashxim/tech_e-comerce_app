import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ecomerce_app/model/product_model.dart';

List<ProductModel> favBag = [];

// ignore: camel_case_types
class favBagNotifier extends StateNotifier<List<ProductModel>> {
  favBagNotifier() : super(favBag);

  void toggleFavorite(int pid, int index) {
    state = [
      for (final product in state)
        if (product.pid == pid)
          product.copyWith(isFavorite: !state[index].isFavorite)
        else
          product,
    ];
  }

  void addItemfav(ProductModel product, int index) {
    // Check if the product is already in the bag
    final index = state.indexWhere((item) => item.pid == product.pid);

    if (index != -1) {
      // If the product exists, update its quantity
      state[index] = state[index].copyWith(qty: state[index].qty);
    } else {
      // If the product doesn't exist, add it to the bag
      state.add(product.copyWith(qty: 1));
    }
  }

  void removeItemfav(int pid) {
    state = [
      for (final product in state)
        if (product.pid != pid) product,
    ];
  }
}

final favBagProvider =
    StateNotifierProvider<favBagNotifier, List<ProductModel>>((ref) {
  return favBagNotifier();
});
