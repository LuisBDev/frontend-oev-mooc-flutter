import 'package:oev_mobile_app/domain/datasources/registration_datasource.dart';
import 'package:oev_mobile_app/domain/repositories/registration_repository.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationDatasource dataSource;

  RegistrationRepositoryImpl({required this.dataSource});

  @override
  Future<List<Map<String, dynamic>>> findRegisteredUsersByConferenceId(
      int conferenceId) {
    return dataSource.findRegisteredUsersByConferenceId(conferenceId);
  }
}
