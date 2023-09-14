import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact>? contacts;
  @override
  void initState() {
    super.initState();
    getPhoneData();
  }

  void getPhoneData() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      // print(contacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: ListView.builder(
        itemCount: contacts!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(contacts![index].name.first),
          );
        },
      ),
    );
  }
}
