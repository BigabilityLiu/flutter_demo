import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

// 调用iOS和Android平台的接口代码
// iOS代码在 AppDelegate.swift中
// Android代码在MainActivity.kt中

class BatteryPage extends StatefulWidget{
  @override
  _BatteryPageState createState() {
    return _BatteryPageState();
  }
}
class _BatteryPageState extends State<BatteryPage>{

  // point1：channel 要唯一，且在iOS和Android调用时一致
  static const platform = const MethodChannel('trendlab.flutter_demo/battery');
  String _batteryLevel = 'Unknow battery level.';

  Future<void> _getBatteryLevel() async{
    String batteryLevel ;
    try{
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result %.';
    } on PlatformException catch (e){
      batteryLevel = "Failed to get battery level: '${e.message}'";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Battery"),
        ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('获取电池容量'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel)
          ],
        ),
      ),
    );
  }

}