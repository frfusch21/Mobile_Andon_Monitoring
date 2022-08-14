import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/User/components/background.dart';
import 'package:flutter_auth/api.dart';
import 'file:///D:/THESIS/Mobile_Flutter/lib/homeTechDash.dart';

class Body extends StatefulWidget {
  final String mechanic_name;
  final String kpk;

  Body(this.mechanic_name, this.kpk);
  @override
  _ApplicationState createState() => new _ApplicationState(mechanic_name, kpk);
}

class _ApplicationState extends State<Body> {
  String kpk ;
  String mechanic_name ;

  _ApplicationState(String mechanic_name, String kpk){
    this.mechanic_name = mechanic_name;
    this.kpk = kpk;
  }
  Timer timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 20), (Timer t) => setState((){}));
  }

  void addValue() {
    setState(() {
      fetchTechDash();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
//      child: Column(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            alignment: Alignment.topLeft,
            child: FutureBuilder(
              future: fetchTechDash(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index){
                      HomeTechDash homeTD = snapshot.data[index];
                        if('${homeTD.redAndon}'== '1' &&
                            '${homeTD.greenAndon}'== '0')
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.red,
                          elevation: 10,
                          child: Container(
                            height:120,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                Text(
                                '${homeTD.lineNumber}',
                                style: TextStyle(fontSize: 32, fontWeight:
                                FontWeight.bold,color: Colors.white),
                                ),
                                Text(
                                'Machine Problem',
                                style: TextStyle(fontSize: 20, fontWeight:
                                FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      else if('${homeTD.redAndon}'== '0' &&
                            '${homeTD.greenAndon}'== '1')
                        return Card(
                          color: Colors.green,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                            child: Container(
                              height:120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  Text(
                                    '${homeTD.lineNumber}',
                                    style: TextStyle(fontSize: 32, fontWeight:
                                    FontWeight.bold,color: Colors.white),
                                  ),
                                  Text(
                                    'Running',
                                    style: TextStyle(fontSize: 20, fontWeight:
                                    FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                        );
                      else if('${homeTD.redAndon}'== '0' &&
                            '${homeTD.greenAndon}'== '0')
                        return Card(
                          color: Colors.grey,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height:120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  Text(
                                  '${homeTD.lineNumber}',
                                  style: TextStyle(fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Machine Off',
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
          ),
        ),
      ),
    );
  }
}
