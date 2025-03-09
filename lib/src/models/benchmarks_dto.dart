// To parse this JSON data, do
//
//     final benchmarks = benchmarksFromJson(jsonString);

import 'dart:convert';

Benchmarks benchmarksFromJson(String str) =>
    Benchmarks.fromJson(json.decode(str));

String benchmarksToJson(Benchmarks data) => json.encode(data.toJson());

class Benchmarks {
  Benchmarks({required this.data, required this.links});

  Benchmarks copyWith({
    required List<BenchmarksDatum> data,
    required BenchmarksLinks links,
  }) => Benchmarks(data: data, links: links);

  List<BenchmarksDatum> data;
  BenchmarksLinks links;

  factory Benchmarks.fromJson(Map<String, dynamic> json) => Benchmarks(
    data: List<BenchmarksDatum>.from(
      json['data'].map((x) => BenchmarksDatum.fromJson(x)),
    ),
    links: BenchmarksLinks.fromJson(json['links']),
  );

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'links': links.toJson(),
  };
}

class BenchmarksDatum {
  BenchmarksDatum({
    required this.type,
    required this.id,
    required this.attributes,
    required this.links,
  });

  String type;
  String id;
  Attributes attributes;
  DatumLinks links;

  factory BenchmarksDatum.fromJson(Map<String, dynamic> json) =>
      BenchmarksDatum(
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
    required this.description,
    required this.category,
    required this.scoreType,
    required this.movementIds,
  });

  String name;
  String description;
  String category;
  String scoreType;
  List<String> movementIds;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    name: json['name'],
    description: json['description'],
    category: json['category'],
    scoreType: json['score_type'],
    movementIds: List<String>.from(json['movement_ids'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'category': category,
    'score_type': scoreType,
    'movement_ids': List<dynamic>.from(movementIds.map((x) => x)),
  };
}

class DatumLinks {
  DatumLinks();

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks();

  Map<String, dynamic> toJson() => {};
}

class BenchmarksLinks {
  BenchmarksLinks({required this.self, required this.next});

  String self;
  String next;

  factory BenchmarksLinks.fromJson(Map<String, dynamic> json) =>
      BenchmarksLinks(self: json['self'], next: json['next']);

  Map<String, dynamic> toJson() => {'self': self, 'next': next};
}
