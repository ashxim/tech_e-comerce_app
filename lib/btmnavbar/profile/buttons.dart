import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  Buttons({super.key, required this.iconData, required this.title});
  final IconData iconData;

  final String title;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300.withOpacity(0.4),
          borderRadius: BorderRadius.circular(50)),
      height: screenheight * 0.05,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(iconData),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
