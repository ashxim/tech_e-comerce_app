import 'package:flutter/material.dart';
import 'package:my_ecomerce_app/constants/themes.dart';

class CategoriesButton extends StatelessWidget {
  const CategoriesButton({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5),
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400),
            overlayColor: MaterialStateProperty.all(kSecondaryColor),
            shadowColor: MaterialStateProperty.all(kBlackColor),
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))))),
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.grey.shade700,
        ),
        label: Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
