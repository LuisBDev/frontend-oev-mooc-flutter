import 'package:dio/dio.dart';
import 'package:oev_mobile_app/config/constants/environment.dart';
import 'package:oev_mobile_app/domain/datasources/user_datasource.dart';
import 'package:oev_mobile_app/domain/entities/user/user_model.dart';
import 'package:oev_mobile_app/infrastructure/mappers/user_mapper.dart';

class UserDataSourceImpl implements UserDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<User> updateUser(int id, Map<String, dynamic> userData) async {
    try {
      final response = await dio.put(
        '/user/update/$id',
        data: userData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserMapper.userJsonToEntity(response.data);
      } else {
        throw Exception(
            'Error al actualizar usuario: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Tiempo de conexión agotado');
      }
      throw Exception(e.response?.data?['message'] ?? 'Error de conexión');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
