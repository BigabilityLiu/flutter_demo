import 'package:flutter/material.dart';

class GridviewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridviewDemo'),),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: List.generate(100, (index) {
              return Center(
                child: Text('$index', style: Theme.of(context).textTheme.headline),
              );
            }),
          );
        } ,
      ),
    );
  }
}