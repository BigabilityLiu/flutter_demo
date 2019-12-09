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
import 'demos/tabController_demo.dart';
import 'demos/gridview_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demos',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.green[600],

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        routes: <String, WidgetBuilder>{
          '/list_demo': (BuildContext context) => new RandomWords(),
          '/form_demo': (BuildContext context) => new MyForm(),
          '/http_demo': (BuildContext context) => new SampleAppPage(),
          '/provider_demo': (BuildContext context) => new ProviderDemoPage(),
          '/battery_demo': (BuildContext context) => new BatteryPage(),
          '/draw_demo': (BuildContext context) => new Signature(),
          '/animation_demo': (BuildContext context) => new AnimationDemo(),
          '/tab_demo': (BuildContext context) => new TabBarDemo(),
          '/gridview_demo': (BuildContext context) => new GridviewDemo(),
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
                    title: Text("Provider数据传递"),
                    onTap: () =>
                        Navigator.of(context).pushNamed('/provider_demo')),
                ListTile(
                    title: Text("Battery获取平台API信息"),
                    onTap: () =>
                        Navigator.of(context).pushNamed('/battery_demo')),
                ListTile(
                    title: Text("Draw"),
                    onTap: () => Navigator.of(context).pushNamed('/draw_demo')),
                ListTile(
                    title: Text("Animation"),
                    onTap: () => Navigator.of(context).pushNamed('/animation_demo')
                    ),
                ListTile(
                    title: Text("TabBar Controller"),
                    onTap: () => Navigator.of(context).pushNamed('/tab_demo')
                    ),
                ListTile(
                  title: Text("GridView & Orientation"),
                  onTap: () => Navigator.of(context).pushNamed('/gridview_demo')
                ),
              ],
            ),
          ),
        ));
  }
}
