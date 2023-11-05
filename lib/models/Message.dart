class Message {
  final int id;
  final String text;
  final bool sentByUser;

  Message({
    required this.id,
    required this.text,
    required this.sentByUser,
  });

  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        sentByUser = json['sentByUser'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'sentByUser': sentByUser,
    };
  }
}
