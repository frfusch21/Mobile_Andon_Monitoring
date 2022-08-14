import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Operator/components/background.dart';
import 'package:flutter_auth/components/rounded_lineNumber.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/api.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Machine_Problem extends StatelessWidget {
  final String line_number;
  final String dropdownValue;
  final String type;
  final OnChangeCallback onChanged;
  Machine_Problem({Key key, @required this.line_number, this.dropdownValue,
    this.type, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Machine Problem'),
      ),
      body: mach_prob(line_number, dropdownValue, type, onChanged),
    );
  }
}

typedef OnChangeCallback = void Function(dynamic value);
class mach_prob extends StatefulWidget {
  final String line_number;
  final String dropdownText;
  final String type;
  final OnChangeCallback onChanged;

  mach_prob(this.line_number, this.dropdownText, this.type, this.onChanged);
  @override
  _ApplicationState createState() => new _ApplicationState(line_number);
}

class _ApplicationState extends State<mach_prob> {
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//  FlutterLocalNotificationsPlugin();

  @override
//  void initState() {
//    super.initState();
//    var initializationSettingsAndroid =
//    AndroidInitializationSettings('flutter_devs');
//    var initSetttings = InitializationSettings(
//        android: initializationSettingsAndroid);
//
//    flutterLocalNotificationsPlugin.initialize(initSetttings,
//        onSelectNotification: onSelectNotification);
//  }

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewScreen(
        payload: payload,
      );
    }));
  }

  String line_number;
  String msg ='';
  String dropdownValue = 'Broken';
  final _formKey = GlobalKey<FormState>();

  _ApplicationState(String line_number) {
    this.line_number = line_number;
  }

  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: Form(key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Line Number",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              RoundedInputField(
                hintText: line_number,
              ),
              Text(
                "\nInput Main Issue:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              DropdownButton(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 15,
                elevation: 26,
                style: TextStyle(color: Colors.deepPurple, fontSize: 22),
                underline: Container(
                  height: 5,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value;
                  });
                  widget.onChanged(value);
                },
                items: <String>['Broken', 'Jammed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              RoundedButton(
                text: "Call Mechanic",
                press: () async{
                  if(_formKey.currentState.validate()) {
                    var resp = await machine_problem(dropdownValue, line_number);
                    print(resp);
                    if(resp.containsKey('status')){
                      if(resp['status']==1){
                        setState((){
                          msg = 'Mechanic is on the Way! \nPlease Wait!';
                        });
                      }
                    }else{
                      setState(() {
                        msg = 'Fail to report';
                      });
                    }
                  };
//                  var android = new AndroidNotificationDetails(
//                        'id', 'channel ', 'description',
//                        priority: Priority.high, importance: Importance.max);
//                  var iOS = new IOSNotificationDetails();
//                  var platform = new NotificationDetails(android: android);
//                  await flutterLocalNotificationsPlugin.show(
//                        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
//                        payload: 'Welcome to the Local Notification demo ');
                },
              ),
              Text(msg, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 21),),
            ],
          ),
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}