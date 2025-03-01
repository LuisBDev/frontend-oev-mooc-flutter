abstract class RegistrationDatasource {
  Future<List<Map<String, dynamic>>> findRegisteredUsersByConferenceId(
      int conferenceId);
}
