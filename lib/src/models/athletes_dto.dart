// To parse this JSON data, do
//
//     final athletes = athletesFromJson(jsonString);

import 'dart:convert';

AthletesDto athletesFromJson(String str) =>
    AthletesDto.fromJson(json.decode(str));

class AthletesDto {
  AthletesDto({required this.data, required this.links});

  AthletesDto copyWith({
    required List<Datum> data,
    required AthletesLinks links,
  }) => AthletesDto(data: data, links: links);

  List<Datum> data;
  AthletesLinks links;

  factory AthletesDto.fromJson(Map<String, dynamic> json) => AthletesDto(
    data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
    links: AthletesLinks.fromJson(json['links']),
  );
}

class Datum {
  Datum({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  String type;
  String id;
  AthleteAttributes attributes;
  DatumLinks links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json['type'],
    id: json['id'],
    attributes: AthleteAttributes.fromJson(json['attributes']),
    links: DatumLinks.fromJson(json['links']),
  );
}

class AthleteAttributes {
  AthleteAttributes({
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.profileImageUrl,
    required this.lastLogin,
  });

  DateTime createdAt;
  String firstName;
  String lastName;
  String email;
  String gender;
  String profileImageUrl;
  DateTime lastLogin;

  factory AthleteAttributes.fromJson(Map<String, dynamic> json) =>
      AthleteAttributes(
        createdAt: DateTime.parse(json['created_at']),
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        gender: json['gender'],
        profileImageUrl: json['profile_image_url'] ?? null,
        lastLogin: DateTime.now(),
      );
}

class DatumLinks {
  DatumLinks({required this.uiAthlete, required this.removeFromAffiliate});

  String uiAthlete;
  String removeFromAffiliate;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    uiAthlete: json['ui_athlete'],
    removeFromAffiliate: json['remove_from_affiliate'],
  );
}

class AthletesLinks {
  AthletesLinks({required this.self, required this.next});

  String self;
  String next;

  factory AthletesLinks.fromJson(Map<String, dynamic> json) =>
      AthletesLinks(self: json['self'], next: json['next']);
}
