import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/dto/request/course_dto.dart';
import 'package:oev_mobile_app/domain/repositories/course_repository.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/course_repository_provider.dart';

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final repository = ref.watch(courseRepositoryProvider);
  return repository.getCourses();
});

final addCourseProvider = StateNotifierProvider<AddCourseNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(courseRepositoryProvider);
  return AddCourseNotifier(repository);
});

class AddCourseNotifier extends StateNotifier<AsyncValue<void>> {
  final CourseRepository repository;

  AddCourseNotifier(this.repository) : super(const AsyncData(null));

  Future<void> addCourse(int userId, CourseRequestDTO courseRequestDTO) async {
    state = const AsyncLoading();
    try {
      await repository.addCourse(userId, courseRequestDTO);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}
