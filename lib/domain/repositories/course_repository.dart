import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/dto/request/course_dto.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses();
  Future<void> addCourse(int userId, CourseRequestDTO courseRequestDTO);
}
