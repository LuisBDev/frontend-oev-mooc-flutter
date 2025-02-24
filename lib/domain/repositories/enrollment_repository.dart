abstract class EnrollmentRepository {
  Future<bool> enrollUserInCourse(int userId, int courseId);
  Future<List<Map<String, dynamic>>> findEnrolledUsersByCourseId(int courseId);
  Future<void> deleteEnrollment(int enrollmentId);
}