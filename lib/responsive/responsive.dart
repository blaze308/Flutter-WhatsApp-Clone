import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreenayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    required this.mobileScreenayout,
    required this.webScreenLayout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 938) {
          return webScreenLayout;
        }
        return mobileScreenayout;
      },
    );
  }
}
