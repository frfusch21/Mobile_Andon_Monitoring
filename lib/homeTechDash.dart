import 'dart:convert';

List<HomeTechDash> homeTechDashFromJson(String str) => List<HomeTechDash>.from(json.decode(str).map((x) => HomeTechDash.fromJson(x)));

String homeTechDashToJson(List<HomeTechDash> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeTechDash {
  HomeTechDash({
    this.greenAndon,
    this.lineNumber,
    this.redAndon,
  });

  int greenAndon;
  String lineNumber;
  int redAndon;

  factory HomeTechDash.fromJson(Map<String, dynamic> json) => HomeTechDash(
    greenAndon: json["green_andon"],
    lineNumber: json["line_number"],
    redAndon: json["red_andon"],
  );

  Map<String, dynamic> toJson() => {
    "green_andon": greenAndon,
    "line_number": lineNumber,
    "red_andon": redAndon,
  };
}
