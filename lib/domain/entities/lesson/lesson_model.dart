class Lesson {
  final int id;
  final int userId;
  final int lessonId;
  final String lessonTitle;
  final String? lessonVideoUrl;
  final int? duration;
  final String status;
  final DateTime? completedAt;

  Lesson({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.lessonTitle,
    this.lessonVideoUrl,
    this.duration,
    required this.status,
    this.completedAt,
  });

  static Lesson fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      userId: json['userId'],
      lessonId: json['lessonId'],
      lessonTitle: json['lessonTitle'],
      lessonVideoUrl: json['lessonVideoUrl'],
      duration: json['duration'],
      status: json['status'],
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
    );
  }
}
