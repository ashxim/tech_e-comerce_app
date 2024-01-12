import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ecomerce_app/model/product_model.dart';

List<ProductModel> itemBag = [];

class ItemBagNotifier extends StateNotifier<List<ProductModel>> {
  ItemBagNotifier() : super(itemBag);

  void addItem(ProductModel product) {
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

  void removeItem(int pid) {
    state = [
      for (final product in state)
        if (product.pid != pid) product,
    ];
  }

  void incrementQty(int pid) {
    state = [
      for (final product in state)
        if (product.pid == pid)
          product.copyWith(qty: product.qty += 1)
        else
          product,
    ];
  }

  void decreaseQty(int pid) {
    state = [
      for (final product in state)
        if (product.pid == pid)
          product.copyWith(qty: product.qty > 0 ? product.qty - 1 : 0)
        else
          product,
    ];
  }

  double get total => state.fold(
      0.0,
      (total, item) =>
          total +
          (item.qty *
              // Replace this with the actual price lookup logic
              // based on the product ID 'item.pid'
              item.price));
}

final itemBagProvider =
    StateNotifierProvider<ItemBagNotifier, List<ProductModel>>((ref) {
  return ItemBagNotifier();
});
