import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/repositories/user_repository.dart';
import 'package:oev_mobile_app/infrastructure/repositories/user_repository_impl.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

final userUpdateProvider =
    StateNotifierProvider<UserUpdateNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserUpdateNotifier(repository);
});

class UserUpdateNotifier extends StateNotifier<AsyncValue<void>> {
  final UserRepository _repository;

  UserUpdateNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> updateUser(int id, Map<String, dynamic> userData) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateUser(id, userData);
      if (result != null) {
        state = const AsyncValue.data(null);
      } else {
        throw Exception('No se pudo actualizar el usuario');
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      throw error; // Re-lanza el error para manejarlo en la UI
    }
  }
}
