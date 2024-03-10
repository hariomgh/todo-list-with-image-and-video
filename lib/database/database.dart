import 'package:hive/hive.dart';

class sampleDataBase{

  List sampleList = [];

  final _myBox = Hive.box('myBox');

  void createInitialData () {
    sampleList = [
      ["Create your samples"],
      ["test1"],
      ["test2"],
    ];
  }

  void loadData() {
    var dataList = _myBox.get("SAMPLELIST");
    if (dataList != null) {
      sampleList = List.from(dataList);
    }
  }

  void updateDataBase () {
    _myBox.put("SAMPLELIST", sampleList);
  }
  // Method to check if a task has an associated image or video
  bool hasImageOrVideoForTask(String taskName) {
    List<dynamic>? taskData = _myBox.get(taskName);
    return taskData != null && taskData.isNotEmpty;
  }

  // Method to get the path of the image or video associated with a task
  // String getImageOrVideoForTask(String taskName) {
  //   List<dynamic>? taskData = _myBox.get(taskName);
  //   if (taskData != null && taskData.isNotEmpty) {
  //     return taskData[0]; // Assuming the first item in the list is the path of the image or video
  //   } else {
  //     return ''; // Return an empty string if no image or video is associated with the task
  //   }
  // }


  // Method to add image path to Hive box
  void addImagePath(String taskName, String imagePath) {
    List<dynamic> taskData = [_myBox.get(taskName) ?? [], imagePath];
    _myBox.put(taskName, taskData);
  }

  // Method to retrieve image path associated with a task
  String getImagePathForTask(String taskName) {
    List<dynamic>? taskData = _myBox.get(taskName);
    if (taskData != null && taskData.isNotEmpty) {
      return taskData[1]; // Assuming the second item in the list is the image path
    } else {
      return ''; // Return an empty string if no image is associated with the task
    }
  }

  // Method to check if a task has an associated image
  bool hasImageForTask(String taskName) {
    List<dynamic>? taskData = _myBox.get(taskName);
    return taskData != null && taskData.isNotEmpty;
  }
}
