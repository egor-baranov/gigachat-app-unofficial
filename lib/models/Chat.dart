import 'dart:convert';

import 'Message.dart';

class ChatModel {
  final int id;
  final String name;
  final List<Message> history;

  ChatModel({
    required this.id,
    required this.name,
    required this.history,
  });

  ChatModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        history = (json['history'] as List<dynamic>)
            .map((e) => Message.fromJson(jsonDecode(e)))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'history': history.map((e) => jsonEncode(e.toJson())).toList(),
    };
  }
}
