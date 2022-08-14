import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/User/components/background.dart';
import 'package:flutter_auth/Screens/User/notif_detail.dart';
import 'package:flutter_auth/api.dart';
import 'file:///D:/THESIS/Mobile_Flutter/lib/notif_alert.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/User/tech_dash.dart';


class notifications extends StatelessWidget {
  final String mechanic_name;
  final String kpk;
  notifications({Key key, @required this.mechanic_name,this.kpk}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Notifications'),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) {
              return tech_dash(mechanic_name: mechanic_name, kpk: kpk);
            },
            ),
            );
          },
          child: Icon(
            Icons.home,  // add custom icons also
          ),
        ),
      ),
      body: notif(mechanic_name,kpk),
    );
  }
}

class notif extends StatefulWidget {
  final String mechanic_name;
  final String kpk;
  notif(this.mechanic_name,this.kpk);
  @override
  notifState createState() => new notifState(mechanic_name,kpk);
}

class notifState extends State<notif> {
  String msg ='';
  String kpk;
  String mechanic_name;

  notifState(String mechanic_name,String kpk) {
    this.mechanic_name = mechanic_name;
    this.kpk = kpk;
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.topLeft,
          child: FutureBuilder(
            future: fetchNotifications(kpk),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index){
                    NotifAlert notif_alert = snapshot.data[index];
                    String id;
                    String line_number;
                    id = '${notif_alert.id}';
                    line_number = '${notif_alert.lineNumber}';
                    return Card(
                      color: kPrimaryLightColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context){
                              return notif_detail(id: id, mechanic_name:mechanic_name, kpk: kpk, line_number: line_number);
                            }));

                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text(
                                '${notif_alert.lineNumber}',
                                style: TextStyle(fontSize: 20, fontWeight:
                                FontWeight.bold),
                              ),
                              Text(
                                'Main Issue: ${notif_alert.mainIssue}',
                                style: TextStyle(fontSize: 20, fontWeight:
                                FontWeight.bold),
                              ),
                              Text(
                                  'Time Created: ${notif_alert.timeCreated}',
                                  style: TextStyle(fontSize: 14),
                              ),
                              if ('${notif_alert.kpk}'!= 'NULL')
                              Text(
                                'Mechanic Appointed (KPK): ${notif_alert.kpk}',
                                style: TextStyle(fontSize: 14, fontWeight:
                                FontWeight.bold),
                              ),
                              if('${notif_alert.timeResponse}'!= 'NULL')
                                Text(
                                  'Time Response: ${notif_alert.timeResponse}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              if('${notif_alert.statusJob}'== '2')
                              Text(
                               'Status: On-Going',
                               style: TextStyle(fontSize: 14, fontWeight:
                               FontWeight.bold),
                              ),
                              if('${notif_alert.statusJob}'== '1')
                                Text(
                                'Status: Active',
                                style: TextStyle(fontSize: 14, fontWeight:
                                FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            }
          ),
        ),
      ),
    );
  }
}