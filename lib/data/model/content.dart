// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'package:dev_partner_exam2/data/model/tags.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Content {
  Content({
    required this.createdAt,
    required this.type,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.contentUrl,
    required this.tags,
  });

  DateTime createdAt;
  String type;
  String title;
  String description;
  String thumbnailUrl;
  String contentUrl;
  List<Tags> tags;
  bool isBookMarked = false;

  String get toDateString => DateFormat('MMMM d, yyyy').format(createdAt);

  Content copyWith({
    DateTime? createdAt,
    String? type,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? contentUrl,
    List<Tags>? tags,
  }) =>
      Content(
        createdAt: createdAt ?? this.createdAt,
        type: type ?? this.type,
        title: title ?? this.title,
        description: description ?? this.description,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        contentUrl: contentUrl ?? this.contentUrl,
        tags: tags ?? this.tags,
      );

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    createdAt: DateTime.parse(json["created_at"]),
    type: json["type"],
    title: json["title"],
    description: json["description"],
    thumbnailUrl: json["thumbnail_url"],
    contentUrl: json["content_url"],
    tags: List<Tags>.from(json["tags"].map((x) => Tags.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "type": type,
    "title": title,
    "description": description,
    "thumbnail_url": thumbnailUrl,
    "content_url": contentUrl,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}