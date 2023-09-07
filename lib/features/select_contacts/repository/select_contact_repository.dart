// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/user_models.dart';
import 'package:whatsapp_clone/features/chat/screens/mobile_chat_screen.dart';

final selectContactRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection("users").get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(" ", "");

        // print(selectedPhoneNum);
        String? ghNum;

        if (selectedPhoneNum.startsWith("0")) {
          ghNum = selectedPhoneNum.replaceFirst("0", "+233");
          // debugPrint(ghNum);
        }

        if (selectedPhoneNum == userData.phoneNumber ||
            ghNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeNme, arguments: {
            "name": userData.name,
            "uid": userData.uid,
          });
        }

        if (!isFound) {
          showSnackBar(
              context: context, content: "User not registered on this app");
        }
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
