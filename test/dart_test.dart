import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo/main.dart';

void main() {
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
    var a = [c, 2, 3];
    // var a = const [c,2,3]; //ERROR, 集合元素必须是编译时常数。

//  声明类成员变量时，const变量必须同时被声明为static的。
//  const变量，变量命名方式应使用全大写加下划线。
//  const变量只能在定义的时候初始化。
//  final变量可以在构造函数参数列表或者初始化列表中初始化。
//  final非常量，但在声明时就能确定值，并且不希望被改变
}