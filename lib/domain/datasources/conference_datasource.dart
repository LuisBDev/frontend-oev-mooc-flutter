import 'package:oev_mobile_app/domain/entities/conference/conference_model.dart';

abstract class ConferenceDatasource {
  Future<List<Conference>> getConference();
  Future<Conference> getConferenceById(int conferenceId);
}
