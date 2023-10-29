import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gigachat_app_unofficial/clients/ApiClient.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../models/Message.dart';
import '../utils/SolarIcons.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController _controller = ScrollController();
  final _inputController = TextEditingController();

  String? token;
  List<Message> messages = [];

  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
  }

  void showBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      isDismissible: true,
      expand: false,
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => SizedBox(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 8,
                decoration: const BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: const Text(
                "Rename Chat",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: const Text(
                "Color Scheme",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: const Text(
                "Language",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: const Text(
                "Advanced Configuration",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            divider(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: const Text(
                "Clear Data",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
      child: Container(
        height: 1,
        width: double.infinity,
        color: CupertinoColors.systemGrey6,
      ),
    );
  }

  void _scrollDown([int delay = 100]) {
    Future.delayed(Duration(milliseconds: delay), () {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  Widget rateCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: Colors.red,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.thumb_up_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.thumb_down_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void send(Message message) {
    setState(
      () {
        if (messages.any((element) => element.id == message.id)) {
          messages[messages.indexWhere((element) => element.id == message.id)] =
              Message(
                id: message.id,
                text: messages[messages.indexWhere((element) => element.id == message.id)].text + message.text,
                sentByUser: message.sentByUser
              );
        } else {
          messages.add(message);
        }
      },
    );
  }

  Widget chatCard(String text, bool my, List<String> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              my ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 340),
                      child: Card(
                        color: my
                            ? Colors.red
                            : CupertinoColors.lightBackgroundGray,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                softWrap: true,
                                style: TextStyle(
                                    color: (my ? Colors.white : Colors.black)),
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!my) const SizedBox(height: 20),
                  ],
                ),
                if (!my)
                  Positioned(
                    bottom: -4,
                    left: 8,
                    child: Card(
                      color: CupertinoColors.systemGrey3,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thumb_up_rounded,
                              color: CupertinoColors.systemGrey,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.thumb_down_rounded,
                              size: 20,
                              color: CupertinoColors.systemGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget message(String text, bool sentByUser) {
    return Container(
      width: double.infinity,
      child: Card(
        color: Colors.black,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  sentByUser
                      ? SizedBox()
                      : SizedBox(
                          width: 18,
                          height: 18,
                          child: Image.asset("assets/icons/gigachat.png"),
                        ),
                  sentByUser ? SizedBox() : SizedBox(width: 4),
                  Text(
                    sentByUser ? "You" : "GigaChat",
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                text,
                softWrap: true,
                style: const TextStyle(color: Colors.white),
                maxLines: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatInput() {
    return GestureDetector(
      onTap: () => _scrollDown(),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow()],
          color: CupertinoColors.white,
        ),
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 16, right: 16),
        child: Row(
          children: [
            IconButton(
              icon: SolarIcons.getBold("Video, Audio, Sound/Microphone Large"),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                onChanged: (text) => _scrollDown,
                onTap: _scrollDown,
                controller: _inputController,
                cursorColor: Colors.black,
                onSubmitted: (String text) {
                  _inputController.clear();
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  hintText: "Message",
                  hintStyle: const TextStyle(color: Colors.black38),
                  fillColor: CupertinoColors.systemGrey6,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                icon: const Icon(CupertinoIcons.up_arrow, color: Colors.white),
                iconSize: 16,
                padding: EdgeInsets.all(0),
                color: Colors.black,
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () async {
                  if (_inputController.text.isEmpty) {
                    return;
                  }
                  String text = _inputController.text;
                  send(
                    Message(
                      id: messages.length + 1,
                      text: text,
                      sentByUser: true,
                    ),
                  );
                  _inputController.clear();
                  _scrollDown(100);
                  ApiClient.sendMessage(
                    messages,
                    (m) {
                      print("select: " + m.toString());
                      send(m);
                      _scrollDown(100);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: chatInput(),
      ),
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 56,
        title: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Chat",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: double.infinity),
              ],
            ),
            Positioned(
              left: 8,
              top: 4,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SolarIcons.getOutline('Arrows/Alt Arrow Left'),
              ),
            ),
            Positioned(
              right: 16,
              top: 4,
              child: GestureDetector(
                onTap: () {
                  showBottomSheet(context);
                },
                child: SolarIcons.getBold('Essentional, UI/Menu Dots'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            verticalDirection: VerticalDirection.down,
            children: [...messages.map((e) => message(e.text, e.sentByUser))],
          ),
        ),
      ),
    );
  }
}
