// To parse this JSON data, do
//
//     final barbellLifts = barbellLiftsFromJson(jsonString);

import 'dart:convert';

BarbellLifts barbellLiftsFromJson(String str) =>
    BarbellLifts.fromJson(json.decode(str));

String barbellLiftsToJson(BarbellLifts data) => json.encode(data.toJson());

class BarbellLifts {
  BarbellLifts({
    required this.data,
    required this.links,
  });

  BarbellLifts copyWith({
    required List<BarbellsDatum> data,
    required BarbellLiftsLinks links,
  }) =>
      BarbellLifts(
        data: data,
        links: links,
      );

  List<BarbellsDatum> data;
  BarbellLiftsLinks links;

  factory BarbellLifts.fromJson(Map<String, dynamic> json) => BarbellLifts(
        data: List<BarbellsDatum>.from(
            json['data'].map((x) => BarbellsDatum.fromJson(x))),
        links: BarbellLiftsLinks.fromJson(json['links']),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'links': links.toJson(),
      };
}

class BarbellsDatum {
  BarbellsDatum({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  String type;
  String id;
  Attributes attributes;
  DatumLinks links;

  factory BarbellsDatum.fromJson(Map<String, dynamic> json) => BarbellsDatum(
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
    required this.name,
    required this.category,
  });

  String name;
  String category;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json['name'],
        category: json['category'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
      };
}

class DatumLinks {
  DatumLinks();

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks();

  Map<String, dynamic> toJson() => {};
}

class BarbellLiftsLinks {
  BarbellLiftsLinks({
    required this.self,
    required this.next,
  });

  String self;
  String next;

  factory BarbellLiftsLinks.fromJson(Map<String, dynamic> json) =>
      BarbellLiftsLinks(
        self: json['self'],
        next: json['next'],
      );

  Map<String, dynamic> toJson() => {
        'self': self,
        'next': next,
      };
}
