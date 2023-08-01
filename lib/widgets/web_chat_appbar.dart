import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';

class WebChatAppBar extends StatelessWidget {
  const WebChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    String url =
        "https://images.unsplash.com/photo-1495211895963-08d8812dcbf0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8aW5zdGFncmFtJTIwcHJvZmlsZXxlbnwwfDB8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60";
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.all(10),
      color: webAppBarColor,
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(url), radius: 30),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          Text(
            info[0]["name"].toString(),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
