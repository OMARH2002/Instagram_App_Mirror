class ReelModel {
  final String id;
  final String userId;
  final String videoUrl;
  final String caption;
  final DateTime timestamp;
  final List<String> likes;

  ReelModel({
    required this.id,
    required this.userId,
    required this.videoUrl,
    required this.caption,
    required this.timestamp,
    this.likes = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'videoUrl': videoUrl,
      'caption': caption,
      'timestamp': timestamp.millisecondsSinceEpoch, // Store as int for Firestore
      'likes': likes,
    };
  }

  factory ReelModel.fromMap(Map<String, dynamic> map) {
    return ReelModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      caption: map['caption'] ?? '',
      timestamp: map['timestamp'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp']) // Fix: Handle int timestamps
          : DateTime.parse(map['timestamp']),
      likes: List<String>.from(map['likes'] ?? []),
    );
  }
}