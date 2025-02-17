import 'package:dio/dio.dart';
import 'package:oev_mobile_app/domain/datasources/enrollment_datasource.dart';
import '../../config/constants/environment.dart';
import '../../domain/errors/auth_errors.dart';

class EnrollmentDatasourceImpl implements LessonDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<bool> enrollUserInCourse(int userId, int courseId) async {
    try {
      final response = await dio.post(
        '/enrollment/create',
        data: {
          'userId': userId,
          'courseId': courseId,
        },
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw WrongCredentials();
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeout();
      }
      throw CustomError('Something wrong happened');
    } catch (e) {
      throw CustomError('Something wrong happened');
    }
  }
}
