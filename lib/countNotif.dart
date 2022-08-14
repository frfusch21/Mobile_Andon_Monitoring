import 'dart:convert';

List<CountNotif> countNotifFromJson(String str) => List<CountNotif>.from(json.decode(str).map((x) => CountNotif.fromJson(x)));

String countNotifToJson(List<CountNotif> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountNotif {
  CountNotif({
    this.count,
  });

  int count;

  factory CountNotif.fromJson(Map<String, dynamic> json) => CountNotif(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}
