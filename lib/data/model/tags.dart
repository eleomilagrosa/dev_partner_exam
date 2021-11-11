import 'package:dev_partner_exam2/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Tags {
  Tags({
    required this.name,
    required this.color,
  });

  String name;
  String color;
  bool isSelected = false;

  Color get toColor {
    switch(color){
      case "all": return AppColors.colorAll;
      case "red": return Colors.red;
      case "yellow": return AppColors.colorYellow;
      case "blue": return Colors.blue;
      case "green": default: return Colors.green;
    }
  }

  Tags copyWith({
    String? name,
    String? color,
  }) =>
      Tags(
        name: name ?? this.name,
        color: color ?? this.color,
      );

  factory Tags.fromRawJson(String str) => Tags.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
    name: json["name"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "color": color,
  };
}
