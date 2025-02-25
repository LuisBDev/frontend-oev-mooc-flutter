import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/conference/conference_model.dart';
import 'package:oev_mobile_app/presentation/providers/conferences_providers/conference_repository_provider.dart';

final conferenceProvider =
    FutureProvider.autoDispose<List<Conference>>((ref) async {
  final repository = ref.watch(conferenceRepositoryProvider);
  return repository.getConference();
});

final conferenceByIdProvider = FutureProvider.family
    .autoDispose<Conference, int>((ref, conferenceId) async {
  final repository = ref.watch(conferenceRepositoryProvider);
  return repository.getConferenceById(conferenceId);
});
