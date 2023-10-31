import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Chat.dart';
import '../utils/SolarIcons.dart';
import 'Chat.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<ChatModel> chats = [];

  Widget searchBox() {
    return Stack(
      children: [
        TextFormField(
          cursorColor: Colors.black,
          obscureText: false,
          inputFormatters: [],
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            fillColor: CupertinoColors.systemGrey6,
            filled: true,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16),
            child: SolarIcons.getOutlineWithSize("Search/Magnifer", 16),
          ),
        ),
      ],
    );
  }

  Widget chatCard(ChatModel chat) {
    return Material(
      color: CupertinoColors.systemBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Chat(chat: chat);
              },
            ),
          )
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 8),
                        Text(chat.history.first.text.substring(0, 30)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        height: 1,
        width: double.infinity,
        color: CupertinoColors.systemGrey6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 16.0,
                right: 16.0,
                bottom: 8,
              ),
              child: searchBox(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Chat(
                          chat: ChatModel(
                            id: 0,
                            name: 'New Chat',
                            history: [],
                          ),
                        );
                      },
                    ),
                  );
                },
                child: const Text(
                  "+ New Chat",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(height: 8),
            ...chats.map(
              (e) => Column(
                children: [
                  chatCard(e),
                  divider(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
