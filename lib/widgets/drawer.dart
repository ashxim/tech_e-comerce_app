import 'package:flutter/material.dart';

import 'package:my_ecomerce_app/model/product_model.dart';

class DrawerListTitle extends StatelessWidget {
  const DrawerListTitle({Key? key, required this.drawerList}) : super(key: key);
  final List<Drawercategories> drawerList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drawerList.length + 1, // +1 for the additional title item
      itemBuilder: (context, index) {
        if (index == 0) {
          // Render the title item
          return Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ClipOval(
                  child: Container(
                    width: 150, // Adjust the width and height as needed
                    height: 150,
                    child: Image.asset(
                      'assets/general/mystore.jpg',
                      fit: BoxFit.cover, // Adjust the BoxFit as needed
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to my store',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        } else {
          final drawerItem =
              drawerList[index - 1]; // Subtract 1 to account for the title item

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(drawerItem.Title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              // Create a ListView.builder for subtitles

              ListView.builder(
                shrinkWrap: true,
                itemCount: drawerItem.subtitles.length,
                itemBuilder: (context, subtitleIndex) {
                  final subtitleLine = drawerItem.subtitles[subtitleIndex];
                  return InkWell(
                    onTap: () {
                      // Handle subtitle line tap
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 3),
                      child: Text(
                        subtitleLine,
                        style: const TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Divider(color: Colors.grey.shade700, indent: 50, endIndent: 10),
            ],
          );
        }
      },
    );
  }
}
