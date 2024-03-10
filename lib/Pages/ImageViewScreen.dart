import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewScreen extends StatefulWidget {
  final String? sampleImage; // Image path
  const ImageViewScreen(this.sampleImage, {Key? key}) : super(key: key);

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Center(
        child: widget.sampleImage != null
            ? Image.file(File(widget.sampleImage!))
            : Text('No Image Found'), // Display a message if no image is found
      ),
    );
  }
}
