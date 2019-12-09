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

  testFunction() {
    var name = 'liu'; 
    // equal to 
    // String name = 'liu';
    // name = 1;// error
    name = 'dong';

    dynamic age = 25;
    age = false;
    Object age1 = 25;
    age1 = false;
     
    final widget1 = Text('widget1');
    const widget2 = Text('widget1');
    // widget1 = Text('2'); // error
    // widget2 = Text('2'); // error

    // const 关键字不仅仅可以用来定义常量，还可以用来创建 常量值，该常量值可以赋予给任何变量。
    var foo = const [];
    foo = [1];
    // foo = 1; // error
    final bar = const [];
    // bar = [1];// error
    bar.add(1);
    const baz = []; // equal to const []
    // baz = [1];// error
    baz.add(1);

    var c = 2;
    var a = [c,2,3];
    // var a = const [c,2,3]; //ERROR, 集合元素必须是编译时常数。

//  声明类成员变量时，const变量必须同时被声明为static的。
//  const变量，变量命名方式应使用全大写加下划线。
//  const变量只能在定义的时候初始化。
//  final变量可以在构造函数参数列表或者初始化列表中初始化。
//  final非常量，但在声明时就能确定值，并且不希望被改变	

  }

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
