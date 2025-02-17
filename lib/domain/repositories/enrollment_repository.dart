abstract class EnrollmentRepository {
  Future<bool> enrollUserInCourse(int userId, int courseId);
}