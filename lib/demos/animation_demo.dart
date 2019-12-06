import 'dart:math';
import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget{
  @override
  _AnimationDemoState createState() {
    return _AnimationDemoState();
  }
}
class _AnimationDemoState extends State<AnimationDemo>{
  // 0:属性变动动画 1:淡入淡出动画 2:弹回中心动画
  int _animationType = 0;
  bool _visiable = true;

  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  Widget _getCurrentAnimationWidget() {
    switch (_animationType) {
      case 0:
        return AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: Center(child: Text('旋转跳跃 我不停歇')),
        );      
        break;
      case 1:
        return AnimatedOpacity(
          opacity: _visiable ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
          ),
        );
      case 2:
        return DraggableCard(
          child: FlutterLogo(
            size: 128,
          ),
        );
      default:
         return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text(' Animation Demo')),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text('属性变动动画'),
              onTap: (){
                setState(() {
                  _animationType = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('淡入淡出动画'),
              onTap: (){
                setState(() {
                  _visiable = true;
                  _animationType = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('弹回动画'),
              onTap: (){
                setState(() {
                  _animationType = 2;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: Center(
        child: _getCurrentAnimationWidget()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            _visiable = !_visiable;

            final random = Random();
            _width = random.nextInt(300).toDouble() + 50.0;
            _height = random.nextInt(300).toDouble() + 50.0;
            _color = Color.fromRGBO(
              random.nextInt(256), 
              random.nextInt(256), 
              random.nextInt(256), 
              1);
            _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}

class DraggableCard extends StatefulWidget  {
  
  final Widget child;
  DraggableCard({this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Alignment _dragAligment = Alignment.center;
  Animation<Alignment> _animation;
  void _runAnimation() {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAligment,
        end: Alignment.center,
      )
    );
    _controller.reset();
    _controller.forward();
  }
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (deetails) {},
      onPanUpdate: (details) {
        setState(() {
          _dragAligment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2)
          );
        });
      },
      onPanEnd: (details) {},
      child: Align(
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}