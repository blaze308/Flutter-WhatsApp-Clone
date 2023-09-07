import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_contoller.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatControllerProvider).chatContacts(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var chatContactData = snapshot.data![index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => MobileChatScreen(
                                    name: "Jai",
                                    uid: "",
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            chatContactData.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              chatContactData.lastMessage,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(chatContactData.profilePic),
                            radius: 30,
                          ),
                          trailing: Text(
                            DateFormat.Hm().format(chatContactData.timeSent),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: dividerColor,
                      indent: 85,
                    )
                  ],
                );
              },
            );
          }),
    );
  }
}
