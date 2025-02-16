import 'package:oev_mobile_app/domain/datasources/enrollment_datasource.dart';
import 'package:oev_mobile_app/domain/repositories/enrollment_repository.dart';

class EnrollmentRepositoryImpl implements EnrollmentRepository {
  final LessonDatasource dataSource;

  EnrollmentRepositoryImpl({required this.dataSource});

  @override
  Future<bool> enrollUserInCourse(int userId, int courseId) async {
    return dataSource.enrollUserInCourse(userId, courseId);
  }
}
