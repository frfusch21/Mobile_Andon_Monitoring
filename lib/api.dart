import 'file:///D:/THESIS/Mobile_Flutter/lib/notif_alert.dart';
import 'file:///D:/THESIS/Mobile_Flutter/lib/homeTechDash.dart';
import 'file:///D:/THESIS/Mobile_Flutter/lib/PreventReport.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future finish_job(String id, line_number, found_issue, action, tools_used) async{
//  String url = 'http://10.35.99.64:5000/login/finish_job';
  String url = 'http://192.168.1.4:5000/login/finish_job';
//  String url = 'http://192.168.1.3:5000/login/finish_job';
  var body = jsonEncode({
    "id" : id,
    "line_number" : line_number,
    "found_issue" : found_issue,
    "action" : action,
    "tools_used" : tools_used
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}

Future response_job(String id, kpk) async{
//  String url = 'http://10.35.99.64:5000/login/response_job';
  String url = 'http://192.168.1.4:5000/login/response_job';
//  String url = 'http://192.168.1.3:5000/login/response_job';
  var body = jsonEncode({
    "id" : id,
    "kpk" :kpk
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}

Future motor_on(String value) async{
//  String url = 'http://10.35.99.64:5000/motor_on';
  String url = 'http://192.168.1.4:5000/motor_on';
//  String url = 'http://192.168.1.3:5000/motor_on';
  var body = jsonEncode({
    "value" : value
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}

Future<List<HomeTechDash>> fetchTechDash() async{
//  String url = 'http://10.35.99.64:5000/login/tech_dash1';
  String url = 'http://192.168.1.4:5000/login/tech_dash1';
//  String url = 'http://192.168.1.3:5000/login/tech_dash1';
  final response = await http.get(url);
  return homeTechDashFromJson(response.body);
}

Future<List<PreventReport>> fetchPrentReport() async{
//  String url = 'http://10.35.99.64:5000/login/tech_dash2';
  String url = 'http://192.168.1.4:5000/login/tech_dash2';
  final response = await http.get(url);
  return preventReportFromJson(response.body);
}

Future<List<NotifAlert>> fetchNotifDetail(String id) async{
//  String url = 'http://10.35.99.64:5000/login/detail_machine';
  String url = 'http://192.168.1.4:5000/login/detail_machine';
//  String url = 'http://192.168.1.3:5000/login/detail_machine';
  var body = jsonEncode({
    "id" : id
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  return notifAlertFromJson(response.body);
}

Future<List<NotifAlert>> fetchNotifications(String kpk) async{
//  String url = 'http://10.35.99.64:5000/login/notifications';
  String url = 'http://192.168.1.4:5000/login/notifications';
//  String url = 'http://192.168.1.3:5000/login/notifications';
  var body = jsonEncode({
    "kpk" : kpk
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  return notifAlertFromJson(response.body);
}

//Future<List<CountNotif>> Count_Notif(String kpk) async{
//  String url = 'http://192.168.1.3:5000/login/count_notif';
//  var body = jsonEncode({
//    "kpk" : kpk
//  });
//  final response = await http.post(url,
//      headers:{"Accept" : "Application/json",},
//      body:body);
//  return countNotifFromJson(response.body);
//}

Future machine_off(String line_number) async{
//  String url = 'http://10.35.99.64:5000/machine_off';
  String url = 'http://192.168.1.4:5000/machine_off';
//  String url = 'http://192.168.1.7:5000/machine_off';

  var body = jsonEncode({
    "line_number" : line_number
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}

Future lineNumber(String line_number) async{
//  String url = 'http://10.35.99.64:5000/line_number';
  String url = 'http://192.168.1.4:5000/line_number';
//  String url = 'http://192.168.1.7:5000/line_number';
  var body = jsonEncode({
    "line_number" : line_number
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}

Future machine_problem(String main_issue, String line_number) async{
//  String url = 'http://10.35.99.64:5000/machine_problem';
  String url = 'http://192.168.1.4:5000/machine_problem';
//  String url = 'http://192.168.1.3:5000/machine_problem';
  var body = jsonEncode({
    "main_issue" : main_issue,
    "line_number" : line_number
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}

Future loginUser(String kpk, String password) async{
//  String url = 'http://10.35.99.64:5000/login';
  String url = 'http://192.168.1.4:5000/login';
//  String url = 'http://192.168.1.3:5000/login';
  var body = jsonEncode({
    "kpk" : kpk,
    "password" : password
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}

Future registerUser(String mechanic_name, String kpk, String password) async{
//  String url = 'http://10.35.99.64:5000/register';
  String url = 'http://192.168.1.4:5000/register';
//  String url = 'http://192.168.1.3:5000/register';
  var body = jsonEncode({
    "mechanic_name" : mechanic_name,
    "kpk" : kpk,
    "password" : password
  });
  final response = await http.post(url,
      headers:{"Accept" : "Application/json",},
      body:body);
  var jsonObject = json.decode(response.body);
  return jsonObject;
}