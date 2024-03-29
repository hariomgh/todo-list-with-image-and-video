// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'dart:io' show File;

import 'package:hive/hive.dart'; // Import Hive
import 'package:path_provider/path_provider.dart' as path_provider;

class CameraScreen extends StatefulWidget {

  final Function(String)? saveImageFunction;
  const CameraScreen(this.saveImageFunction, {Key? key}) : super(key: key);

  // get saveImageFunction => saveImageFunction;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  late Box<String> imageBox;

  @override
  void initState() {
    super.initState();
    // Initialize Hive
    _initHive();
  }

  Future<void> _initHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    // Set Hive box directory
    Hive.init(appDocumentDir.path);
    // Open Hive box
    imageBox = await Hive.openBox('images');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: FlutterCamera(
          color: Colors.yellow,
          onImageCaptured: (value) async {
            final path = value.path;
            print("::::::::::::::::::::::::::::::::: $path");
            if (path.contains('.jpg')) {
              if (widget.saveImageFunction != null) { // Check if saveImageFunction is provided
                widget.saveImageFunction!(path); // Call saveImageFunction with the path
              }

              await imageBox.add(path);
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