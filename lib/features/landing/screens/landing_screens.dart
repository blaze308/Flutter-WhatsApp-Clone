import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const Text(
            "Welcome to WhatsApp",
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: size.height / 12),
          Image.asset("assets/bg.png",
              height: 330, width: 330, color: tabColor),
          SizedBox(height: size.height / 16),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms and Service',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.75,
            child: CustomButton(
              text: "AGREE AND CONTINUE",
              onPressed: () => navigateToLoginScreen(context),
            ),
          )
        ],
      )),
    );
  }
}
