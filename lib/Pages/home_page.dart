import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quasmo/database/database.dart';
import 'package:quasmo/util/dialog_box.dart';
import 'package:quasmo/util/each_tile.dart';

import 'camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  sampleDataBase db = sampleDataBase();
  final _controller  = TextEditingController();
  List _foundList = [];




  @override
  void initState() {
    if(_myBox.get("SAMPLELIST") == null){
      db.createInitialData();
    } else {
      db.loadData();
    }
    _foundList = db.sampleList;
    super.initState();
  }

  //save a task
  void saveNewTask() {
    setState(() {
      db.sampleList.add([ _controller.text,]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // to create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.sampleList.removeAt(index);
      print("delete function call");
    });
    db.updateDataBase();
  }

  void saveImage(String imagePath) {
    setState(() {
      db.sampleList.add([imagePath]);
    });
    db.updateDataBase();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Quasmo",style: TextStyle(
          color: Colors.white,
        ),),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          searchBox(),
          Expanded(
            child: ListView.builder(
              itemCount: _foundList.length,
              itemBuilder: (context, index) {
                return EachTile(
                    sampleName: _foundList[index] [0],
                  deleteFunction: (context) => deleteTask(index),
                  saveImageFunction: saveImage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,),
        decoration: BoxDecoration(
          color: Color(0xff3368C6),
          border: Border.all(
            color: Color(0xff3368C6),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          style: TextStyle(color: Colors.white),
          onChanged: _runFilter,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
              prefixIconConstraints: BoxConstraints(
                maxHeight: 20,
                maxWidth: 25,
              ),
              border: InputBorder.none,
              hintText: ' Search',
              hintStyle: TextStyle(
                color: Colors.white,
              ),

          ),
        ),
      ),
    );
  }


  void _runFilter(String enteredKeyword) {
    List filteredList = [];

    if (enteredKeyword.isEmpty) {
      setState(() {
        filteredList = db.sampleList;
      });
    } else {
      setState(() {
        filteredList = db.sampleList
            .where((sample) => sample[0].toString().toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      });
    }
    setState(() {
      _foundList = filteredList;
    });
  }
}
