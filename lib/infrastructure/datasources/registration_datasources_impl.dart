import 'package:dio/dio.dart';
import 'package:oev_mobile_app/domain/datasources/registration_datasource.dart';
import '../../config/constants/environment.dart';
import '../../domain/errors/auth_errors.dart';

class RegistrationDatasourceImpl implements RegistrationDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<List<Map<String, dynamic>>> findRegisteredUsersByConferenceId(
      int conferenceId) async {
    try {
      final response = await dio
          .get('/registration/findRegisteredUsersByConferenceId/$conferenceId');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Error al obtener los usuarios inscritos');
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
