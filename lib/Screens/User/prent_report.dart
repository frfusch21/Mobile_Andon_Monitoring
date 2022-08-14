import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/User/components/background.dart';
import 'package:flutter_auth/Screens/User/notifications.dart';
import 'package:flutter_auth/Screens/User/tech_dash.dart';
import 'package:flutter_auth/api.dart';
import 'file:///D:/THESIS/Mobile_Flutter/lib/PreventReport.dart';


class prent_report extends StatelessWidget {
  final String mechanic_name;
  final String kpk;
  prent_report({Key key, @required this.mechanic_name, this.kpk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.notifications), onPressed: () async{
                var resp = await fetchNotifications(kpk);

                Navigator.push(context,MaterialPageRoute(
                  builder: (context)
                  {
                    return notifications(mechanic_name:mechanic_name,kpk: kpk);
                  },
                ),
                );
              }),
            ],
          ),
        ],
        title: new Text('Predictive Maintenance'),
      ),
      body: prent(mechanic_name, kpk),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Andon Monitor\n\n\nHi ' + mechanic_name + '\nKPK: ' + kpk,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color:Colors.white),
              ),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(kPrimaryColor.withOpacity(0.3), BlendMode.dstATop),
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

class prent extends StatefulWidget {
  final String mechanic_name;
  final String kpk;

  prent(this.mechanic_name, this.kpk);
  @override
  _ApplicationState createState() => new _ApplicationState(mechanic_name, kpk);
}

class _ApplicationState extends State<prent> {
  String kpk ;
  String mechanic_name ;

  _ApplicationState(String mechanic_name, String kpk){
    this.mechanic_name = mechanic_name;
    this.kpk = kpk;
  }
  int counter = 0;

  Widget build(BuildContext context) {
    return Background(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.topLeft,
          child: Column(
              children: <Widget>[
              Text(
                "Predictive Maintenance Report",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
           FutureBuilder(
               future: fetchPrentReport(),
               builder: (context, snapshot){
                 if(snapshot.hasData){
                   return ListView.builder(
                     itemCount: snapshot.data.length,
                     shrinkWrap: true,
                     itemBuilder: (BuildContext context, index){
                       PreventReport prentRep = snapshot.data[index];
                         return Card(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15.0),
                           ),
                           color: Colors.blue,
                           elevation: 10,
                           child: Container(
                             height:120,
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget> [
                                 Text(
                                   '${prentRep.machNo}',
                                   style: TextStyle(fontSize: 32, fontWeight:
                                   FontWeight.bold,color: Colors.white
                                   ),
                                 ),
                                 Text(
                                   'Cutoff Date: ${prentRep.cutoffDate}',
                                   style: TextStyle(fontSize: 20, fontWeight:
                                   FontWeight.bold,color: Colors.white),
                                 ),
                                 Text(
                                   'Probable Issue: ${prentRep.mainIssue}',
                                   style: TextStyle(fontSize: 20, fontWeight:
                                   FontWeight.bold,color: Colors.white),
                                 ),
                               ],
                             ),
                           ),
                         );
                     },
                   );
                 }
                 return CircularProgressIndicator();
               }
            )
          ],
        ),
      ),
    );
  }
}