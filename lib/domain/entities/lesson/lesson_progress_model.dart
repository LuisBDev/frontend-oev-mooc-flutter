class LessonProgress {
  final int id;
  final int userId;
  final int lessonId;
  final String lessonTitle;
  final String? lessonVideoUrl;
  final int? duration;
  final String status;
  final DateTime? completedAt;

  LessonProgress({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.lessonTitle,
    this.lessonVideoUrl,
    this.duration,
    required this.status,
    this.completedAt,
  });

  static LessonProgress fromJson(Map<String, dynamic> json) {
    return LessonProgress(
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
