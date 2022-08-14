import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Operator/components/background.dart';
import 'package:flutter_auth/Screens/Operator/Machine_Problem.dart';
import 'package:flutter_auth/components/small_button.dart';
import 'package:flutter_auth/components/rounded_input_ops.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/api.dart';

class Body extends StatefulWidget {
  final String line_number;
  final int quota;
  final int act1, act2, act3, act4;

  Body(this.line_number, this.quota, this.act1, this.act2,this.act3,this.act4);
  @override
  _ApplicationState createState() => new _ApplicationState(line_number,
      quota, act1, act2, act3, act4);
}

class _ApplicationState extends State<Body> {
  String line_number;
  int quota;
  double var1=0, var2=0, var3=0, var4=0;
  double target1=0, target2=0, target3=0, target4=0;
  int act1, act2, act3, act4;
  String msg ='';
  String _value = 'OFF';

  _ApplicationState(String line_number, int quota, int act1, int act2,
      int act3, int act4){
    this.line_number = line_number;
    this.quota = quota;
    this.act1 = act1;
    this.act2 = act2;
    this.act3 = act3;
    this.act4 = act4;
  }

  Widget build(BuildContext context) {
    return Background(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '\nMACHINE '+line_number,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    RoundedInputOps(
                      hintText: "Today's Quota",
                      onChanged: (value) {
                        quota = int.parse(value);
                      },
                    ),
                Text('Speed: '),
                DropdownButton(
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("OFF"),
                        value: 'OFF',
                      ),
                      DropdownMenuItem(
                        child: Text("MED"),
                        value: 'MED',
                      ),
                      DropdownMenuItem(
                        child: Text("HIGH"),
                        value: 'HIGH',
                      ),
                    ],
                    onChanged: (value) async{
                      setState(() {
                        _value = value;
                      });
                      await motor_on(_value);
                    }),
                  ],
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(label: Text("Shift")),
                        DataColumn(label: Text("Target")),
                        DataColumn(label: Text("Actual")),
                        DataColumn(label: Text("Variance")),
                        DataColumn(label: Text("Speed")),
                      ],
                      rows: <DataRow>[
                        DataRow(
                        cells: <DataCell>[
                          DataCell(Text("Shift 1")),
                          DataCell(Text(
                            '$target1',
                          )),
                        DataCell(TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            act1 = int.parse(value);
                          },
                        ),
                        ),
                        DataCell(Text(
                          '$var1',
                          )
                        ),
                          DataCell(Text("MED")),
                          ],
                      ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Shift 2")),
                            DataCell(Text(
                              '$target2',
                              )
                            ),
                            DataCell(TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                act2 = int.parse(value);
                              },
                            ),),
                            DataCell(Text(
                              '$var2',
                            )
                            ),
                            if(var1>0)
                              DataCell(Text("HIGH")),
                            if(var1<=0)
                              DataCell(Text("MED")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Shift 3")),
                            DataCell(Text(
                              '$target3',
                              )
                            ),
                            DataCell(TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                act3 = int.parse(value);
                              },
                            ),),
                            DataCell(Text(
                              '$var3',
                            )
                            ),
                            if(var2>0)
                              DataCell(Text("HIGH")),
                            if(var2<=0)
                              DataCell(Text("MED")), //Harus ada If disini
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Shift 4")),
                            DataCell(Text(
                              '$target4',
                            )),
                            DataCell(TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                act4 = int.parse(value);
                              },
                            ),),
                            DataCell(Text(
                              '$var4',
                            )
                            ),
                            if(var3>0)
                              DataCell(Text("HIGH")),
                            if(var3<=0)
                              DataCell(Text("MED")),
                          ],
                        ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SmallButton(
                    text: "Calculate Target",
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    press: () {
                        setState(() {
                          target1 = (quota/4);
                          target2 = (quota/4)+var1;
                          target3 = (quota/4)+var2;
                          target4 = (quota/4)+var3;
                          print(quota);
                        });
                    },
                  ),
                  SmallButton(
                      text: "Submit Actual",
                      color: Colors.green,
                      textColor: Colors.white,
                      press: () {
                          setState(() {
                            var1 = (target1/1) - act1;
                            var2 = (target2/1) - act2;
                            var3 = (target3/1) - act3;
                            var4 = (target4/1) - act4;
                            print(var1);
                          });
                      },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SmallButton(
                    text: "Machine Problem",
                    color: Colors.yellow,
                    textColor: Colors.black,
                    press: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                        return Machine_Problem(line_number: line_number);
                      },
                      ),
                      );
                    },
                  ),
                  SmallButton(
                      text: "Machine Off",
                      color: Colors.red,
                      textColor: Colors.white,
                      press: () async {
                        var resp = await machine_off(line_number);
                        if (resp.containsKey('line_number')) {
                          setState(() {
                            msg = resp['line_number'];
                          });
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) {
                            return WelcomeScreen();
                          }));
                        };
                      }
                    ),
                ],
                ),
                Text(msg, style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18),),
              ],
          ),
        ),
    );
  }

}
