import 'dart:convert';

List<PreventReport> preventReportFromJson(String str) => List<PreventReport>.from(json.decode(str).map((x) => PreventReport.fromJson(x)));

String preventReportToJson(List<PreventReport> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreventReport {
  PreventReport({
    this.cutoffDate,
    this.machNo,
    this.mainIssue,
  });

  String cutoffDate;
  String machNo;
  String mainIssue;

  factory PreventReport.fromJson(Map<String, dynamic> json) => PreventReport(
    cutoffDate: json["cutoff_date"],
    machNo: json["mach_no"],
    mainIssue: json["main_issue"],
  );

  Map<String, dynamic> toJson() => {
    "cutoff_date": cutoffDate,
    "mach_no": machNo,
    "main_issue": mainIssue,
  };
}
