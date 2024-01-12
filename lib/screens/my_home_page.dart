import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:my_ecomerce_app/controller/itembag_controller.dart';
import 'package:my_ecomerce_app/controller/product_controller.dart';
import 'package:my_ecomerce_app/data/products.dart';
import 'package:my_ecomerce_app/screens/Product_details.dart';
import 'package:my_ecomerce_app/screens/cart_page.dart';
import 'package:my_ecomerce_app/widgets/categories_buttons.dart';
import 'package:my_ecomerce_app/widgets/drawer.dart';
import 'package:my_ecomerce_app/widgets/hotsales.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage({
    super.key,
  });
  int index = 0;

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = productItems.length;
    final itemBag = ref.watch(itemBagProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    // Create a list of widgets for each tab
    List<int> shuffledIndices = List.generate(products, (index) => index);
    shuffledIndices = shuffledIndices.reversed.toList();

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPrimaryColor, kSecondaryColor.withOpacity(0.4)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: buildDrawer(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: const Center(
            child: Text(
              'My store',
              style: TextStyle(color: kWhiteColor),
            ),
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: [
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
                  color: kWhiteColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 150,
                  width: screenWidth * 0.95,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        kPrimaryColor,
                        kSecondaryColor.withOpacity(0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Your Tech store',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '    Find the phone and accessories'
                            '\n             you’re looking for',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Go and shop',
                            style: TextStyle(
                              color: kThirdColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/products/hwawi.png',
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.5,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                    children: const [
                      CategoriesButton(
                        icon: Icons.phone_android_outlined,
                        title: 'All',
                      ),
                      CategoriesButton(
                        icon: Icons.computer,
                        title: 'Computers',
                      ),
                      CategoriesButton(
                        icon: Icons.headphones_outlined,
                        title: 'Headsets',
                      ),
                      CategoriesButton(
                        icon: Icons.speaker,
                        title: 'Speakers',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hot Sales',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  width: double.infinity,
                  height: 230,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0.2),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(getIndex: index)));
                      },
                      child: HotSales(productIndex: index),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                MasonryGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final shuffledIndex = shuffledIndices[index];
                    if (index < products) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(getIndex: shuffledIndex),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: HotSales(productIndex: shuffledIndex),
                        ),
                      );
                    } else {
                      // Handle the case where the index is out of bounds (optional).
                      // You might want to display a different widget or show an error message.
                      return Text("Index out of bounds");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return DrawerListTitle(
      drawerList: drawerList,
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
