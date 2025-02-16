import 'package:oev_mobile_app/domain/datasources/lesson_datasource.dart';
import 'package:oev_mobile_app/domain/entities/lesson/lesson_model.dart';
import 'package:oev_mobile_app/domain/repositories/lesson_repository.dart';
import 'package:oev_mobile_app/infrastructure/datasources/lesson_datasource_impl.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonDataSource dataSource;

  LessonRepositoryImpl({LessonDataSource? dataSource}) : dataSource = dataSource ?? LessonDatasourceImpl();

  @override
  Future<List<Lesson>> getLessonsByCourseId(int courseId) {
    return dataSource.getLessonsByCourseId(courseId);
  }
}
