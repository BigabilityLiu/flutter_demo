import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDemo extends StatefulWidget {
  
  @override
  _SharedPreferencesDemoState createState() => _SharedPreferencesDemoState();
}

class _SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  int _counter = 0;
  static const String COUNTER_KEY = 'SharedPreferencesDemoState_Counter';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Preferences'),),
      body: Center(child: Text('$_counter'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addCounter,
      ),
    );
  }
  @override
  void initState() {
    _loadCounter();
    super.initState();
  }
  void  _loadCounter() async {
    final shared = await SharedPreferences.getInstance();
    setState(() {
      _counter = shared.getInt(COUNTER_KEY) ?? 0;
    });
  }
  void _addCounter() async {
    final shared = await SharedPreferences.getInstance();
    await shared.setInt(COUNTER_KEY, _counter + 1);
    setState(() {
      _counter = shared.getInt(COUNTER_KEY);
    });
  }
}