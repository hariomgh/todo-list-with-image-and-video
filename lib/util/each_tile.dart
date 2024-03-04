import 'package:flutter/material.dart';

import '../Pages/camera.dart';

class EachTile extends StatelessWidget {
  final String sampleName;
  final Function(BuildContext)? deleteFunction;
  final Function(String)? saveImageFunction;

  EachTile({
    Key? key,
    required this.sampleName,
    required this.deleteFunction,
    this.saveImageFunction,
  });

  void navigateToCameraScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen(saveImageFunction)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
      child: GestureDetector(
        onTap: () {
          navigateToCameraScreen(context);
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xff3368C6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.camera_alt, color: Colors.white,),
                  SizedBox(width: 8,),
                  Text(
                    sampleName,
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
                  onPressed: () => deleteFunction!(context),
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
