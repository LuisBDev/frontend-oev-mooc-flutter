import 'package:dio/dio.dart';
import 'package:oev_mobile_app/config/constants/environment.dart';
import 'package:oev_mobile_app/domain/datasources/user_datasource.dart';
import 'package:oev_mobile_app/domain/entities/user/user_model.dart';
import 'package:oev_mobile_app/infrastructure/mappers/user_mapper.dart';

class UserDataSourceImpl implements UserDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      // Aumentamos el timeout para dar más tiempo a la respuesta
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  @override
  Future<User> updateUser(int id, Map<String, dynamic> userData) async {
    try {
      // Agregamos logging para debug
      print('Updating user with ID: $id');
      print('Update data: $userData');

      final response = await dio.put(
        '/user/update/$id',
        data: userData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer ${token}'
          },
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      // Logging de la respuesta
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          return UserMapper.userJsonToEntity(response.data);
        }
        throw Exception('La respuesta del servidor está vacía');
      } else {
        final errorMessage = response.data?['message'] ?? 'Error desconocido en la actualización';
        throw Exception('Error del servidor: $errorMessage');
      }
    } on DioException catch (e) {
      print('DioError: ${e.type}');
      print('DioError message: ${e.message}');
      print('DioError response: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Tiempo de conexión agotado');
      }
      if (e.response?.data != null) {
        final errorMessage = e.response?.data?['message'] ?? e.message;
        throw Exception('Error de servidor: $errorMessage');
      }
      throw Exception('Error de conexión: ${e.message}');
    } catch (e) {
      print('Error inesperado: $e');
      throw Exception('Error inesperado: $e');
    }
  }
}