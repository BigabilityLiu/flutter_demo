import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';


// iOS
// <key>NSCameraUsageDescription</key>
// <string>Can I use the camera please?</string>
// <key>NSMicrophoneUsageDescription</key>
// <string>Can I use the mic please?</string>


class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera ;
  TakePictureScreen({Key key, @required this.camera}) : super(key : key);
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  @override
  void initState() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a Picture'),),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return CameraPreview(_controller);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.takePicture(path);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              )
            );
          }catch (e){
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key,@required this.imagePath}) : super( key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture'),),
      body: Image.file(File(imagePath)),
    );
  }
}