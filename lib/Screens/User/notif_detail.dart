import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/User/components/background.dart';
import 'package:flutter_auth/api.dart';
import 'package:flutter_auth/components/small_button.dart';
import 'package:flutter_auth/components/rounded_lineNumber.dart';
import 'package:flutter_auth/components/rounded_form.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/User/notifications.dart';
import 'file:///D:/THESIS/Mobile_Flutter/lib/notif_alert.dart';


class notif_detail extends StatelessWidget {
  final String id;
  final String kpk;
  final String mechanic_name;
  final String line_number;
  notif_detail({Key key, @required this.id, this.mechanic_name,this.kpk, this.line_number}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Technician Action'),
      ),
      body: tech_action(this.id, this.mechanic_name,this.kpk, this.line_number),
    );
  }
}

class tech_action extends StatefulWidget {
  final String id;
  final String mechanic_name;
  final String kpk;
  final String line_number;
  tech_action(this.id, this.mechanic_name, this.kpk, this.line_number);
  @override
  tech_actionState createState() => new tech_actionState(id,mechanic_name,kpk, line_number);
}

class tech_actionState extends State<tech_action> {
  final _formKey = GlobalKey<FormState>();
  String msg ='';
  String action ='';
  String found_issue ='';
  String tools_used ='';
  String id;
  String kpk;
  String mechanic_name;
  String line_number;

  tech_actionState(String id, String mechanic_name,String kpk, String line_number) {
    this.id = id;
    this.mechanic_name = mechanic_name;
    this.kpk = kpk;
    this.line_number = line_number;
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.topLeft,
        child: FutureBuilder(
          future: fetchNotifDetail(id),
          builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index){
              NotifAlert notif_detail = snapshot.data[index];
                if('${notif_detail.statusJob}'== '1')
                return Form(key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Job Id",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.id}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Line Number",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.lineNumber}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Main Issue",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.mainIssue}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "KPK Response",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child:RoundedInputField(
                                hintText: kpk,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SmallButton(
                                text: "Start Job",
                                color: kPrimaryColor,
                                textColor: Colors.white,
                                press: () async {
                                  var resp = await response_job(id, kpk);
                                  if (resp.containsKey('status')) {
                                    Navigator.push(context, MaterialPageRoute
                                      (builder: (context) {
                                      return notifications(mechanic_name:mechanic_name,kpk: kpk);
                                    }));
                                  };
                                }
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              else if('${notif_detail.statusJob}'== '2')
                  return Form(key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Job Id",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.id}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Line Number",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.lineNumber}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Main Issue",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.mainIssue}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Responded by(KPK)",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.kpk}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Time Responded",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '${notif_detail.timeResponse}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Found Issue",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          Expanded(
                            flex: 6,
                            child:RoundedInputField1(
                                onChanged: (value) {
                                  found_issue = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Action",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child:RoundedInputField1(
                                onChanged: (value) {
                                  action = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Tools Used",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                ":",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child:RoundedInputField1(
                                onChanged: (value) {
                                  tools_used = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          SmallButton(
                              text: "Submit",
                              color: kPrimaryColor,
                              textColor: Colors.white,
                              press: () async {
                                var resp = await finish_job(id, line_number, found_issue,
                                    action, tools_used);
                                if (resp.containsKey('status')) {
                                  Navigator.push(context, MaterialPageRoute
                                    (builder: (context) {
                                    return notifications(mechanic_name:mechanic_name,kpk: kpk);
                                  }));
                                };
                              }
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
              },
            );
          }
          return CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}