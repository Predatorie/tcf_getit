// To parse this JSON data, do
//
//     final athletes = athletesFromJson(jsonString);

import 'dart:convert';

AthletesDto athletesFromJson(String str) =>
    AthletesDto.fromJson(json.decode(str));

class AthletesDto {
  AthletesDto({
    this.data,
    this.links,
  });

  AthletesDto copyWith({
    List<Datum> data,
    AthletesLinks links,
  }) =>
      AthletesDto(
        data: data ?? this.data,
        links: links ?? this.links,
      );

  List<Datum> data;
  AthletesLinks links;

  factory AthletesDto.fromJson(Map<String, dynamic> json) => AthletesDto(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: AthletesLinks.fromJson(json["links"]),
      );
}

class Datum {
  Datum({
    this.type,
    this.id,
    this.attributes,
    this.links,
  });

  String type;
  String id;
  AthleteAttributes attributes;
  DatumLinks links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        id: json["id"],
        attributes: AthleteAttributes.fromJson(json["attributes"]),
        links: DatumLinks.fromJson(json["links"]),
      );
}

class AthleteAttributes {
  AthleteAttributes({
    this.createdAt,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.profileImageUrl,
    this.lastLogin,
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
        createdAt: DateTime.parse(json["created_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        gender: json["gender"],
        profileImageUrl: json["profile_image_url"] == null
            ? null
            : json["profile_image_url"],
      );
}

class DatumLinks {
  DatumLinks({
    this.uiAthlete,
    this.removeFromAffiliate,
  });

  String uiAthlete;
  String removeFromAffiliate;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
        uiAthlete: json["ui_athlete"],
        removeFromAffiliate: json["remove_from_affiliate"],
      );
}

class AthletesLinks {
  AthletesLinks({
    this.self,
    this.next,
  });

  String self;
  String next;

  factory AthletesLinks.fromJson(Map<String, dynamic> json) => AthletesLinks(
        self: json["self"],
        next: json["next"],
      );
}
