import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/User/components/body.dart';
import 'package:flutter_auth/Screens/User/prent_report.dart';
import 'package:flutter_auth/Screens/User/notifications.dart';
import 'package:flutter_auth/api.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';

class tech_dash extends StatelessWidget {
  final String mechanic_name;
  final String kpk;
  tech_dash({Key key, @required this.mechanic_name, this.kpk}) : super(key: key);
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: new AppBar(
              backgroundColor: kPrimaryColor,
              actions: <Widget>[
                new Stack(
                  children: <Widget>[
                    new IconButton(icon: Icon(Icons.notifications),
                        onPressed: () async{
                      var resp = await fetchNotifications(kpk);
                      Navigator.push(context,MaterialPageRoute(
                      builder: (context)
                      {
                        return notifications(mechanic_name: mechanic_name,kpk: kpk);
                      },
                    ),
                    );
                    }),
//                    counter != 0 ? new Positioned(
//                      right: 11,
//                      top: 11,
//                      child: new Container(
//                        padding: EdgeInsets.all(2),
//                        decoration: new BoxDecoration(
//                          color: Colors.red,
//                          borderRadius: BorderRadius.circular(6),
//                        ),
//                        constraints: BoxConstraints(
//                          minWidth: 14,
//                          minHeight: 14,
//                        ),
//                        child: Text(
//                          '$counter',
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 8,
//                          ),
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
//                    ) : new Container()
                  ],
                ),
              ],
              title: new Text('Technician Dashboard'),
            ),
      body: Body(mechanic_name, kpk),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Andon Monitor\n\n\nHi ' + mechanic_name +
                  '\nKPK: ' + kpk,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,
                  color:Colors.white),
            ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          kPrimaryColor.withOpacity(0.3), BlendMode.dstATop),
                      image: AssetImage("assets/icons/homepage.png"),
                      fit: BoxFit.cover)
              ),
            ),
            ListTile(
              leading: Icon(Icons.dvr),
              title: Text('View Current Machine Status Report',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                  return tech_dash(mechanic_name: mechanic_name, kpk: kpk);
                },
                ),
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.done_outline),
              title: Text('View Predictive Maintenance Report',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                  return prent_report(mechanic_name: mechanic_name, kpk: kpk);
                },
                ),
                );
              }
            ),

            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text('Logout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return WelcomeScreen();
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
