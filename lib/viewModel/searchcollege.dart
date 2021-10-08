// To parse this JSON data, do
//
//     final searchcollege = searchcollegeFromJson(jsonString);

import 'dart:convert';

List<Searchcollege> searchcollegeFromJson(String str) => List<Searchcollege>.from(json.decode(str).map((x) => Searchcollege.fromJson(x)));

String searchcollegeToJson(List<Searchcollege> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Searchcollege {
  Searchcollege({
    this.domains,
    this.name,
    this.country,
    this.alphaTwoCode,
    this.stateProvince,
    this.webPages,
  });

  List<String> domains;
  String name;
  String country;
  String alphaTwoCode;
  String stateProvince;
  List<String> webPages;

  factory Searchcollege.fromJson(Map<String, dynamic> json) => Searchcollege(
    domains: List<String>.from(json["domains"].map((x) => x)),
    name: json["name"],
    country: json["country"],
    alphaTwoCode: json["alpha_two_code"],
    stateProvince: json["state-province"] == null ? null : json["state-province"],
    webPages: List<String>.from(json["web_pages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "domains": List<dynamic>.from(domains.map((x) => x)),
    "name": name,
    "country": country,
    "alpha_two_code": alphaTwoCode,
    "state-province": stateProvince == null ? null : stateProvince,
    "web_pages": List<dynamic>.from(webPages.map((x) => x)),
  };
}
