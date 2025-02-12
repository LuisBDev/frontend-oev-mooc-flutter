import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';
import 'package:oev_mobile_app/domain/entities/dto/request/course_dto.dart';

abstract class CourseDatasource {
  Future<List<Course>> getCourses();
  Future<List<CourseEnrolled>> getEnrolledCourses(int userId);
  Future<void> addCourse(int userId, CourseRequestDTO courseRequestDTO);
  Future<Course> getCourseById(int courseId);
  Future<List<Course>> getCoursesPublishedByInstructor(int userId);
}
