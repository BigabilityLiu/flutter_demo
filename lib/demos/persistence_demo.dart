import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PersistenceDemo extends StatefulWidget {
  
  @override
  _PersistenceDemoState createState() => _PersistenceDemoState();
}

class _PersistenceDemoState extends State<PersistenceDemo> {
  var _sharedPreferenceCounter = 0;
  var _localFileCounter = 0;
  static const String COUNTER_KEY = 'SharedPreferencesDemoState_Counter';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Preferences'),),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('$_sharedPreferenceCounter'),
            Text('$_localFileCounter'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addSharedCounter,
      ),
    );
  }
  @override
  void initState() {
    _loadSharedCounter();
    
    super.initState();
  }
  void  _loadSharedCounter() async {
    final shared = await SharedPreferences.getInstance();
    final fileCounter = await CounterStorage().readCounter();
    setState(() {
      _sharedPreferenceCounter = shared.getInt(COUNTER_KEY) ?? 0;
      _localFileCounter = fileCounter;
    });
  }
  void _addSharedCounter() async {
    final shared = await SharedPreferences.getInstance();
    await shared.setInt(COUNTER_KEY, _sharedPreferenceCounter + 1);
    await CounterStorage().writeCounter(_localFileCounter + 1);
    setState(() {
      _sharedPreferenceCounter = shared.getInt(COUNTER_KEY);
      _localFileCounter = _localFileCounter + 1;
    });
  }
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }
  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }
  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return int.parse(contents);
    }catch (e){
      return 0;
    }
  }
}