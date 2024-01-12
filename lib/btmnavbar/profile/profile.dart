import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_ecomerce_app/btmnavbar/profile/buttons.dart';
import 'package:my_ecomerce_app/constants/themes.dart';
import 'package:my_ecomerce_app/screens/login_screen.dart';
import 'package:my_ecomerce_app/widgets/btmnavbar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
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
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: -20.0,
                    blurRadius: 120.0,
                    offset: const Offset(-200, 0))
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 30),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              color: kBlackColor,
                              borderRadius: BorderRadius.circular(80),
                              border: Border.all(
                                color: kBackground,
                                width: 6,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500, // Shadow color
                                  blurRadius: 5, // Spread of the shadow
                                  offset: const Offset(
                                      2, 8), // Offset of the shadow
                                ),
                              ],
                              image: const DecorationImage(
                                image: AssetImage('assets/general/profile.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child:
                                RippleBorder(), // Add the RippleBorder widget here
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenheight * 0.04,
                      ),
                      const Text(
                        'User_Shop',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Buttons(
                      title: 'Edit Profile',
                      iconData: Icons.person,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Buttons(
                      title: 'Shopping Adress',
                      iconData: Icons.location_on_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Buttons(
                      title: 'Order History',
                      iconData: Icons.history_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Buttons(
                        title: 'Coupons', iconData: Icons.assignment_rounded),
                    const SizedBox(
                      height: 10,
                    ),
                    Buttons(title: 'Cards', iconData: Icons.credit_card_sharp),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(height: screenheight * 0.04),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500, // Shadow color
                        blurRadius: 20, // Spread of the shadow
                        offset: const Offset(5, 6),
                      )
                    ]),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(Icons.logout_outlined),
                      label: const Text('Log Out'),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(180, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                40.0), // Adjust the radius as needed
                          ),
                          backgroundColor: kBackground),
                    ))
              ],
            ),
          ),
        ));
  }
}

class RippleBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100), // Adjust the size as needed
      painter: RipplePainter(),
    );
  }
}

class RipplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color =
          kSecondaryColor.withOpacity(0.2) // Replace with your desired color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      final rippleRadius = radius + i * 15.0; // Adjust the ripple size
      canvas.drawCircle(center, rippleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
