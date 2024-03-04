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
}