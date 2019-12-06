// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'demos/list_demo.dart';
import 'demos/form_demo.dart';
import 'demos/http_demo.dart';
import 'demos/provider_demo.dart';
import 'demos/battery_demo.dart';
import 'demos/draw_demo.dart';
import 'demos/animation_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demos',
        theme: new ThemeData(
            primaryColor: Colors.brown,
        ),
        routes: <String, WidgetBuilder>{
          '/list_demo': (BuildContext context) => new RandomWords(),
          '/form_demo': (BuildContext context) => new MyForm(),
          '/http_demo': (BuildContext context) => new SampleAppPage(),
          '/provider_demo': (BuildContext context) => new ProviderDemoPage(),
          '/battery_demo': (BuildContext context) => new BatteryPage(),
          '/draw_demo': (BuildContext context) => new Signature(),
          '/animation_demo': (BuildContext context) => new AnimationDemo(),
        },
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text("Demo"),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                    title: Text("List"),
                    onTap: () => Navigator.of(context).pushNamed('/list_demo')),
                ListTile(
                    title: Text("Form"),
                    onTap: () => Navigator.of(context).pushNamed('/form_demo')),
                ListTile(
                    title: Text("Networking"),
                    onTap: () => Navigator.of(context).pushNamed('/http_demo')),
                ListTile(
                    title: Text("Provider"),
                    onTap: () =>
                        Navigator.of(context).pushNamed('/provider_demo')),
                ListTile(
                    title: Text("Battery"),
                    onTap: () =>
                        Navigator.of(context).pushNamed('/battery_demo')),
                ListTile(
                    title: Text("Draw"),
                    onTap: () => Navigator.of(context).pushNamed('/draw_demo')),
                ListTile(
                    title: Text("Animation"),
                    onTap: () => Navigator.of(context).pushNamed('/animation_demo')),
              ],
            ),
          ),
        ));
  }
}
