// To parse this JSON data, do
//
//     final termsConditionsModel = termsConditionsModelFromJson(jsonString);

import 'dart:convert';

List<TermsConditionsModel> termsConditionsModelFromJson(String str) => List<TermsConditionsModel>.from(json.decode(str).map((x) => TermsConditionsModel.fromJson(x)));

String termsConditionsModelToJson(List<TermsConditionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TermsConditionsModel {
  int? id;
  String? value;
  bool? hindi;
  String? hindiValue;
  DateTime? createdAt;
  DateTime? updatedAt;

  TermsConditionsModel({
    this.id,
    this.value,
    this.hindi,
    this.hindiValue,
    this.createdAt,
    this.updatedAt,
  });

  factory TermsConditionsModel.fromJson(Map<String, dynamic> json) => TermsConditionsModel(
    id: json["id"],
    value: json["value"],
    hindi: json["hindi"],
    hindiValue: json["hindiValue"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "hindi": hindi,
    "hindiValue": hindiValue,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
