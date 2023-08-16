import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  bool isLoading = false;
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      try {
        ref
            .read(authControllerProvider)
            .signInWithPhone(context, "+${country!.phoneCode}$phoneNumber");

        setState(() {
          isLoading = true;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context: context, content: "fill out all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Enter your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("WhatsApp will need to verify your phone number"),
            const SizedBox(height: 10),
            TextButton(
              onPressed: pickCountry,
              child: const Text("Pick Country"),
            ),
            Row(
              children: [
                if (country != null) Text("+${country!.phoneCode}"),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: const InputDecoration(hintText: "phone number"),
                  ),
                )
              ],
            ),
            const Spacer(),
            isLoading
                ? SizedBox(
                    width: 90,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        showSnackBar(context: context, content: "Please wait ");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 85, 81, 81),
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text(
                        "NEXT",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
                : SizedBox(
                    width: 90,
                    height: 40,
                    child: CustomButton(
                      text: "NEXT",
                      onPressed: sendPhoneNumber,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
