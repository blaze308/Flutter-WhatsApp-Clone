import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class UserInformtionScreen extends ConsumerStatefulWidget {
  static const String routeName = "/user-informaion";
  const UserInformtionScreen({super.key});

  @override
  ConsumerState<UserInformtionScreen> createState() =>
      _UserInformtionScreenState();
}

class _UserInformtionScreenState extends ConsumerState<UserInformtionScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String url =
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

    void selectImage() async {
      image = await pickImageFromGallery(context);
      setState(() {});
    }

    void storeUserData() {
      String name = nameController.text.trim();

      if (name.isNotEmpty) {
        ref
            .read(authControllerProvider)
            .saveUserDataToFirebase(context, name, image);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(children: [
                image == null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(url),
                        radius: 64,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 64,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo)),
                )
              ]),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(hintText: "Enter your name"),
                    ),
                  ),
                  IconButton(
                      onPressed: storeUserData, icon: const Icon(Icons.done))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
