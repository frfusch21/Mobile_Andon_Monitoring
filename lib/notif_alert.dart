import 'dart:convert';

List<NotifAlert> notifAlertFromJson(String str) => List<NotifAlert>.from(json.decode(str).map((x) => NotifAlert.fromJson(x)));

String notifAlertToJson(List<NotifAlert> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotifAlert {
  NotifAlert({
    this.action,
    this.foundIssue,
    this.id,
    this.kpk,
    this.lineNumber,
    this.mainIssue,
    this.statusJob,
    this.timeCreated,
    this.timeFinish,
    this.timeResponse,
    this.toolsUsed,
  });

  String action;
  String foundIssue;
  int id;
  String kpk;
  String lineNumber;
  String mainIssue;
  int statusJob;
  String timeCreated;
  String timeFinish;
  String timeResponse;
  String toolsUsed;

  factory NotifAlert.fromJson(Map<String, dynamic> json) => NotifAlert(
    action: json["action"],
    foundIssue: json["found_issue"],
    id: json["id"],
    kpk: json["kpk"],
    lineNumber: json["line_number"],
    mainIssue: json["main_issue"],
    statusJob: json["statusJob"],
    timeCreated: json["time_created"],
    timeFinish: json["time_finish"],
    timeResponse: json["time_response"],
    toolsUsed: json["tools_used"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "found_issue": foundIssue,
    "id": id,
    "kpk": kpk,
    "line_number": lineNumber,
    "main_issue": mainIssue,
    "statusJob": statusJob,
    "time_created": timeCreated,
    "time_finish": timeFinish,
    "time_response": timeResponse,
    "tools_used": toolsUsed,
  };
}
