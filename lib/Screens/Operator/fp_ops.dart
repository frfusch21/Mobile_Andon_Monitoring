import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Operator/ops_dash.dart';
import 'package:flutter_auth/api.dart';

class fp_ops_dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Operator Dashboard'),
      ),
      body: fp_dash(),
    );
  }
}

typedef OnChangeCallback = void Function(dynamic value);
class fp_dash extends StatefulWidget {
  final String dropdownText;
  final String type;
  final OnChangeCallback onChanged;

  fp_dash({this.dropdownText, this.type, this.onChanged});

  @override
  fp_dashState createState() {
    return fp_dashState();
  }
}

class fp_dashState extends State<fp_dash> {
  String dropdownValue = 'A1';
  final _formkey = GlobalKey<FormState>();
  String msg ='';
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formkey,
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Input Machine Line Number',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                items: <String>['A1', 'A2','A3','A4','A5','A6']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () async {
                      if(_formkey.currentState.validate()) {
                        var resp = await lineNumber(dropdownValue);
                        print(resp);
                        if(resp.containsKey('line_number')){
                          setState((){
                            msg = resp['line_number'];
                          });
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context){
                             return ops_dash(line_number: resp['line_number']);
                          }));
                        }else{
                          setState(() {
                            msg = 'Machine Failed to Run';
                          });
                        }
                      }
                    },
                    child: Text('Run Machine'),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
