import 'package:oev_mobile_app/domain/datasources/conference_datasource.dart';
import 'package:oev_mobile_app/domain/entities/conference/conference_model.dart';
import 'package:oev_mobile_app/domain/repositories/conference_repository.dart';
import 'package:oev_mobile_app/infrastructure/datasources/conference_datasources_impl.dart';

class ConferenceRepositoryImpl implements ConferenceRepository {
  final ConferenceDatasource conferenceDatasource;

  ConferenceRepositoryImpl({ConferenceDatasource? conferenceDatasource})
      : conferenceDatasource =
            conferenceDatasource ?? ConferenceDatasourceImpl();

  @override
  Future<List<Conference>> getConference() {
    return conferenceDatasource.getConference();
  }

  @override
  Future<Conference> getConferenceById(int conferenceId) {
    return conferenceDatasource.getConferenceById(conferenceId);
  }
}
