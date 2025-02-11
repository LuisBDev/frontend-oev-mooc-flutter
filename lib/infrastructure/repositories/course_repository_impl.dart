import 'package:oev_mobile_app/domain/datasources/course_datasource.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';
import 'package:oev_mobile_app/domain/entities/dto/request/course_dto.dart';
import 'package:oev_mobile_app/domain/repositories/course_repository.dart';
import 'package:oev_mobile_app/infrastructure/datasources/course_datasource_impl.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseDatasource courseDatasource;

  CourseRepositoryImpl({CourseDatasource? courseDatasource}) : courseDatasource = courseDatasource ?? CourseDatasourceImpl();

  @override
  Future<List<Course>> getCourses() {
    return courseDatasource.getCourses();
  }

  @override
  Future<List<CourseEnrolled>> getEnrolledCourses(int userId) {
    return courseDatasource.getEnrolledCourses(userId);
  }

  @override
  Future<void> addCourse(int userId, CourseRequestDTO courseRequestDTO) {
    throw courseDatasource.addCourse(userId, courseRequestDTO);
  }
}
