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
final enrolledUsersProvider = FutureProvider.family<List<Map<String, dynamic>>, int>((ref, courseId) async {
  final repository = ref.read(enrollmentRepositoryProvider);
  return repository.findEnrolledUsersByCourseId(courseId);
});

final deleteEnrollmentProvider = StateNotifierProvider<DeleteEnrollmentNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(enrollmentRepositoryProvider);
  return DeleteEnrollmentNotifier(repository);
});

class DeleteEnrollmentNotifier extends StateNotifier<AsyncValue<void>> {
  final EnrollmentRepository repository;

  DeleteEnrollmentNotifier(this.repository) : super(const AsyncData(null));

  Future<void> deleteEnrollment(int enrollmentId) async {
    state = const AsyncLoading();
    try {
      await repository.deleteEnrollment(enrollmentId);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}