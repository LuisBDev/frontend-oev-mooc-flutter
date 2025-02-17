// lib/presentation/providers/enrollment_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/repositories/enrollment_repository.dart';
import 'package:oev_mobile_app/domain/datasources/enrollment_datasource.dart';
import 'package:oev_mobile_app/infrastructure/datasources/enrollment_datasource_impl.dart';
import 'package:oev_mobile_app/infrastructure/repositories/enrollment_repository_impl.dart';

// Datasource Provider
final enrollmentDatasourceProvider = Provider<LessonDatasource>((ref) {
  return EnrollmentDatasourceImpl();
});

// Repository Provider
final enrollmentRepositoryProvider = Provider<EnrollmentRepository>((ref) {
  final datasource = ref.read(enrollmentDatasourceProvider);
  return EnrollmentRepositoryImpl(dataSource: datasource);
});

// Enrollment Provider
final enrollmentProvider = FutureProvider.family<bool, Map<String, int>>((ref, data) async {
  final repository = ref.read(enrollmentRepositoryProvider);
  final userId = data['userId']!;
  final courseId = data['courseId']!;
  return await repository.enrollUserInCourse(userId, courseId);
});
