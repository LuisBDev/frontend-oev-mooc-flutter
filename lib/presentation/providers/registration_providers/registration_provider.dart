import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/repositories/registration_repository.dart';
import 'package:oev_mobile_app/domain/datasources/registration_datasource.dart';
import 'package:oev_mobile_app/infrastructure/datasources/registration_datasources_impl.dart';
import 'package:oev_mobile_app/infrastructure/repositories/registration_repository_impl.dart';

// Datasource Provider
final registrationDatasourceProvider = Provider<RegistrationDatasource>((ref) {
  return RegistrationDatasourceImpl();
});

// Repository Provider
final registrationRepositoryProvider = Provider<RegistrationRepository>((ref) {
  final datasource = ref.read(registrationDatasourceProvider);
  return RegistrationRepositoryImpl(dataSource: datasource);
});

// Provider de lista de participantes inscritos a una conferencia
final registeredUsersProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>(
        (ref, conferenceId) async {
  final repository = ref.read(registrationRepositoryProvider);
  return repository.findRegisteredUsersByConferenceId(conferenceId);
});
