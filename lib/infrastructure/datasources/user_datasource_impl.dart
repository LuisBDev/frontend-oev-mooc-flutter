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
      );

      return UserMapper.userJsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('Connection timeout');
      }
      throw Exception(e.message ?? 'Something went wrong');
    }
  }
}
