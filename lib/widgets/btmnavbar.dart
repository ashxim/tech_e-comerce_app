import 'package:flutter/material.dart';
import 'package:my_ecomerce_app/btmnavbar/favouritepage.dart';
import 'package:my_ecomerce_app/btmnavbar/profile/profile.dart';
import 'package:my_ecomerce_app/btmnavbar/search.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/screens/my_home_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BtmNavBar extends StatefulWidget {
  const BtmNavBar({super.key});

  @override
  State<BtmNavBar> createState() => _Nav_barState();
}

class _Nav_barState extends State<BtmNavBar> {
  List pages = [
    MyHomePage(),
    const FavouritePage(),
    const Search(),
    const Profile(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: GNav(
        backgroundColor: kSecondaryColor.withOpacity(0.6),
        onTabChange: onTap,
        selectedIndex: currentIndex,
        rippleColor: Colors.grey.shade600,
        hoverColor: Colors.grey.shade500,
        gap: 8,
        activeColor: kPrimaryColor,
        iconSize: 28,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 300),
        tabBackgroundColor: Colors.grey[300]!,
        color: Colors.black,
        tabs: const [
          GButton(
            text: 'Home',
            icon: Icons.home_outlined,
          ),
          GButton(
            text: 'Wishlist',
            icon: Icons.favorite_border_outlined,

            // Use a valid icon, e.g., Icons.favorite
          ),
          GButton(
            text: 'search',
            icon: Icons.search_outlined,

            // Use a valid icon, e.g., Icons.favorite
          ),
          GButton(
            text: 'profile',
            icon: Icons.person_2_outlined,

            // Use a valid icon, e.g., Icons.favorite
          ),
        ],
      ),
    );
  }
}
