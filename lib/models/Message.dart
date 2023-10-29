class Message {
  int id = 0;
  String text = "";
  bool sentByUser = true;

  Message({
    required this.id,
    required this.text,
    required this.sentByUser,
  });
}