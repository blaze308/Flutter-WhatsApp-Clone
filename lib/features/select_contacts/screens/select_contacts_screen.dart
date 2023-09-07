import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/error_screen.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = "/select-contact";
  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text("Select contact"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: ref.watch(getContactsProvider).when(
              data: (contactlist) => ListView.builder(
                  itemCount: contactlist.length,
                  itemBuilder: (context, index) {
                    final contact = contactlist[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: () => selectContact(ref, contact, context),
                        child: ListTile(
                          title: Text(
                            contact.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          leading: contact.photo == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.blueGrey,
                                  radius: 30,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                  radius: 30,
                                ),
                        ),
                      ),
                    );
                  }),
              error: (error, stackTrace) =>
                  ErrorScreen(error: error.toString()),
              loading: () => const Loader(),
            ));
  }
}
