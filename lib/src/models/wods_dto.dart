// To parse this JSON data, do
//
//     final workouts = workoutsFromJson(jsonString);

import 'dart:convert';

WorkoutsDto workoutsFromJson(String str) =>
    WorkoutsDto.fromJson(json.decode(str));

String workoutsToJson(WorkoutsDto data) => json.encode(data.toJson());

class WorkoutsDto {
  WorkoutsDto({required this.data, required this.links});

  WorkoutsDto copyWith({
    required List<WodDatum> data,
    required WorkoutsLinks links,
  }) => WorkoutsDto(data: data, links: links);

  List<WodDatum> data;
  WorkoutsLinks links;

  factory WorkoutsDto.fromJson(Map<String, dynamic> json) => WorkoutsDto(
    data: List<WodDatum>.from(json['data'].map((x) => WodDatum.fromJson(x))),
    links: WorkoutsLinks.fromJson(json['links']),
  );

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'links': links.toJson(),
  };
}

class WodDatum {
  WodDatum({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  String type;
  String id;
  Attributes attributes;
  DatumLinks links;

  factory WodDatum.fromJson(Map<String, dynamic> json) => WodDatum(
    type: json['type'],
    id: json['id'],
    attributes: Attributes.fromJson(json['attributes']),
    links: DatumLinks.fromJson(json['links']),
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'id': id,
    'attributes': attributes.toJson(),
    'links': links.toJson(),
  };
}

class Attributes {
  Attributes({
    required this.createdAt,
    required this.scheduledDateInt,
    required this.scheduledDate,
    required this.track,
    required this.displayOrder,
    required this.title,
    required this.description,
    required this.scoreType,
    required this.publishAt,
    required this.isPublished,
    required this.movementIds,
  });

  DateTime createdAt;
  int scheduledDateInt;
  DateTime scheduledDate;
  Track track;
  double displayOrder;
  String title;
  String description;
  String scoreType;
  DateTime publishAt;
  bool isPublished;
  List<String> movementIds;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    createdAt: DateTime.parse(json['created_at']),
    scheduledDateInt: json['scheduled_date_int'],
    scheduledDate: DateTime.parse(json['scheduled_date']),
    track: Track.fromJson(json['track']),
    displayOrder: json['display_order'].toDouble(),
    title: json['title'],
    description: json['description'],
    scoreType: json['score_type'],
    publishAt: DateTime.parse(json['publish_at']),
    isPublished: json['is_published'],
    movementIds: List<String>.from(json['movement_ids'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'created_at': createdAt.toIso8601String(),
    'scheduled_date_int': scheduledDateInt,
    'scheduled_date': scheduledDate.toIso8601String(),
    'track': track.toJson(),
    'display_order': displayOrder,
    'title': title,
    'description': description,
    'score_type': scoreType,
    'publish_at': publishAt.toIso8601String(),
    'is_published': isPublished,
    'movement_ids': List<dynamic>.from(movementIds.map((x) => x)),
  };
}

class Track {
  Track({required this.id, required this.type, required this.attributesFor});

  String id;
  String type;
  AttributesFor attributesFor;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    id: json['id'],
    type: json['type'],
    attributesFor: AttributesFor.fromJson(json['attributes_for']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'attributes_for': attributesFor.toJson(),
  };
}

class AttributesFor {
  AttributesFor({
    required this.createdAt,
    required this.name,
    required this.type,
  });

  DateTime createdAt;
  String name;
  String type;

  factory AttributesFor.fromJson(Map<String, dynamic> json) => AttributesFor(
    createdAt: DateTime.parse(json['created_at']),
    name: json['name'],
    type: json['type'],
  );

  Map<String, dynamic> toJson() => {
    'created_at': createdAt.toIso8601String(),
    'name': name,
    'type': type,
  };
}

class DatumLinks {
  DatumLinks({required this.uiResults});

  String uiResults;

  factory DatumLinks.fromJson(Map<String, dynamic> json) =>
      DatumLinks(uiResults: json['ui_results']);

  Map<String, dynamic> toJson() => {'ui_results': uiResults};
}

class WorkoutsLinks {
  WorkoutsLinks({required this.self, required this.uiCalendar});

  String self;
  String uiCalendar;

  factory WorkoutsLinks.fromJson(Map<String, dynamic> json) =>
      WorkoutsLinks(self: json['self'], uiCalendar: json['ui_calendar']);

  Map<String, dynamic> toJson() => {'self': self, 'ui_calendar': uiCalendar};
}
