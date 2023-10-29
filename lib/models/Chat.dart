import 'Message.dart';

class Chat {
  String name = "";
  List<Message> history = [];

  Chat({
    required this.name,
    required this.history,
  });
}
