import 'package:oev_mobile_app/domain/entities/conference/conference_model.dart';

class ConferenceMapper {
  static Conference userJsonToEntity(Map<String, dynamic> json) {
    return Conference(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? 'No category',
      status: json['status'] ?? '',
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : DateTime.now(),
      lastUpdate: json['lastUpdate'] != null
          ? DateTime.parse(json['lastUpdate'])
          : DateTime.now(),
      userId: json['userId'],
      creatorName: json['creatorName'] ?? 'Creator Name',
    );
  }
}
