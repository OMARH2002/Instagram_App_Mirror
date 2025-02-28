class Message {
  final String senderUID;
  final String receiverUID;
  final String text;
  final DateTime timestamp;

  Message({
    required this.senderUID,
    required this.receiverUID,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
      senderUID: json['senderUID'],
      receiverUID: json['receiverUID'],
      text: json['text'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'senderUID': senderUID,
    'receiverUID': receiverUID,
    'text': text,
    'timestamp': timestamp.millisecondsSinceEpoch,
  };
}
