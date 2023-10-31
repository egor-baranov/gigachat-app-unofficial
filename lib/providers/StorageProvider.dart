import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Chat.dart';

class StorageProvider {

  static Future<List<ChatModel>> getChats() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var saved = prefs.getString("chats");
    if (saved == null) {
      return [];
    }

    return jsonDecode(saved);
  }

  static Future<ChatModel> createChat() async {
    var chats = await getChats();

    var chat = ChatModel(id: chats.length + 1, name: 'New Chat', history: []);
    saveChat(chat);

    return chat;
  }

  static Future<void> saveChats(List<ChatModel> chats) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("chats", jsonEncode(chats));
  }

  static Future<void> saveChat(ChatModel chat) async {
    var chats = await getChats();

    if (chats.any((element) => element.id == chat.id)) {
      chats.map((e) => e.id == chat.id ? chat : e);
    } else {
      chats.add(chat);
    }
  }
}