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

    var result = (jsonDecode(saved) as List<dynamic>)
        .map((e) => jsonDecode(e))
        .map(
          (e) => ChatModel.fromJson(e),
        )
        .toList();
    return result;
  }

  static void createChat(Function(ChatModel) callback) async {
    var chats = await getChats();

    var chat = ChatModel(id: chats.length + 1, name: 'New Chat', history: []);
    saveChat(chat);

    callback(chat);
  }

  static Future<void> saveChats(List<ChatModel> chats) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(
      "chats",
      jsonEncode(chats.map((e) => jsonEncode(e.toJson())).toList()),
    );
  }

  static Future<void> saveChat(ChatModel chat) async {
    var chats = await getChats();

    if (chats.any((element) => element.id == chat.id)) {
      chats = chats.map((e) => e.id == chat.id ? chat : e).toList();
    } else {
      chats.add(chat);
    }

    saveChats(chats);
  }
}
