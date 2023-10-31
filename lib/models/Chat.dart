import 'Message.dart';

class ChatModel {
  int id = 0;
  String name = "";
  List<Message> history = [];

  ChatModel({
    required this.id,
    required this.name,
    required this.history,
  });
}
