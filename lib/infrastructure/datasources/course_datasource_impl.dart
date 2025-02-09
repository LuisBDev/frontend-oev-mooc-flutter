import 'package:dio/dio.dart';
import 'package:oev_mobile_app/config/constants/environment.dart';
import 'package:oev_mobile_app/domain/datasources/course_datasource.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/dto/request/course_dto.dart';
import 'package:oev_mobile_app/infrastructure/mappers/course_mapper.dart';

class CourseDatasourceImpl implements CourseDatasource {
  final _dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<List<Course>> getCourses() async {
    try {
      final response = await _dio.get('/course/findAll');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CourseMapper.userJsonToEntity(json)).toList();
      } else {
        throw Exception('Error al cargar los cursos');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }

  @override
  Future<void> addCourse(int userId, CourseRequestDTO courseRequestDTO) async {
    try {
      final response = await _dio.post(
        '/course/create/$userId',
        data: courseRequestDTO.toJson(),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Error al agregar el curso');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }
}
