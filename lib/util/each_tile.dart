import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Pages/ImageViewScreen.dart';
import '../Pages/camera.dart';
import '../database/database.dart';

class EachTile extends StatefulWidget {
  final String sampleName;
  final String? sampleImage; // Image data
  final Function(BuildContext)? deleteFunction;
  final Function(String)? saveImageFunction;

  EachTile({
    Key? key,
    required this.sampleName,
    this.sampleImage, // Image data
    required this.deleteFunction,
    this.saveImageFunction,
  });

  @override
  State<EachTile> createState() => _EachTileState();
}

class _EachTileState extends State<EachTile> {
  bool mediaStored = false;
  final _myBox = Hive.box('mybox');
  sampleDataBase db = sampleDataBase();

  @override
  void initState() {
    if(_myBox.get("SAMPLELIST") == null){
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void navigateToCameraOrImageView(BuildContext context) {
    if (widget.sampleImage != null) {
      // If an image is available, open ImageViewScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageViewScreen(widget.sampleImage)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen(widget.saveImageFunction)),
      );
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ImageViewScreen(widget.sampleImage)),
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
      child: GestureDetector(
        onTap: () {
          navigateToCameraOrImageView(context);
        },
        child: Container(

          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color(0xff3368C6),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  color: Color(0xFFBEBEBE),
                  offset: Offset(10, 10),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-10, -10),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.camera_alt, color: Colors.white,),
                  SizedBox(width: 8,),
                  Text(
                    widget.sampleName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Container(
                height: 35,
                width: 35,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () => widget.deleteFunction!(context),
                  color: Colors.white,
                  iconSize: 18,
                  icon: Icon(Icons.delete),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
