abstract class RegistrationRepository {
  Future<void> createRegistration(int userId, int conferenceId);
  Future<void> deleteRegistration(int registrationId);
  Future<List<Map<String, dynamic>>> findRegisteredUsersByConferenceId(
      int conferenceId);
}
