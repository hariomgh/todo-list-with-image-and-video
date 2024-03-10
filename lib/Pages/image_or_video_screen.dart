import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'dart:io' show File;

class CameraScreen extends StatefulWidget {
  const CameraScreen(Function(String p1)? saveImageFunction, {super.key});

  get saveImageFunction => saveImageFunction;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: FlutterCamera(
          color: Colors.yellow,
          onImageCaptured: (value) {
            final path = value.path;
            print("::::::::::::::::::::::::::::::::: $path");
            if (path.contains('.jpg')) {
              if (widget.saveImageFunction != null) { // Check if saveImageFunction is provided
                widget.saveImageFunction!(path); // Call saveImageFunction with the path
              }
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Image.file(File(path)),
                    );
                  });
            }
          },
          onVideoRecorded: (value) {
            final path = value.path;
            print('::::::::::::::::::::::::;; dkdkkd $path');
            ///Show video preview .mp4
          },
        ),
      ),
    );
  }
}