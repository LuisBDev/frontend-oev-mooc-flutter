abstract class RegistrationRepository {
  Future<List<Map<String, dynamic>>> findRegisteredUsersByConferenceId(
      int conferenceId);
}
