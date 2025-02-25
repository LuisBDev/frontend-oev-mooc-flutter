import 'package:oev_mobile_app/domain/entities/conference/conference_model.dart';

abstract class ConferenceRepository {
  Future<List<Conference>> getConference();
  Future<Conference> getConferenceById(int ConferenceId);
}
