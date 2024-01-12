import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_ecomerce_app/auth.dart';
import 'package:my_ecomerce_app/btmnavbar/favouritepage.dart';
import 'package:my_ecomerce_app/firebase_options.dart';
import 'package:my_ecomerce_app/screens/login_screen.dart';
import 'package:my_ecomerce_app/screens/my_home_page.dart';
import 'package:my_ecomerce_app/widgets/btmnavbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
    child: DevicePreview(
      enabled: true,
      builder: (context) => MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        scrollBehavior: AppScrollBehavior(),
        home: const FireAuth(),
      ),
    ),
  ));
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.trackpad,
      };
}
