import 'package:flutter/material.dart';

import 'colors.dart';
import 'responsive/responsive.dart';
import 'screens/mobile_screen_layout.dart';
import 'screens/web_screen_layout.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WhatsApp UI",
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: const ResponsiveLayout(
        mobileScreenayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    ),
  );
}
