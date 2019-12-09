import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Custom Scroll View'),
            expandedHeight: 200,
            flexibleSpace: Placeholder(),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text('$index')),
              childCount: 100
            ),
          )
        ],
      ),
    );
  }
}