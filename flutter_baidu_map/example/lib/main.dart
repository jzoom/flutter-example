import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baidu_map/flutter_baidu_map.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  initState() {

    initBaidu();

    super.initState();
  }

  void initBaidu() async{
    bool result = await FlutterBaiduMap.init();
    if(result){
      print("百度地图加载成功...");

     await FlutterBaiduMap.startLocation();
      print("正在监听...");

      FlutterBaiduMap.locationUpdate.listen(  (Map data){
        print("获取到百度地图定位:$data");
      });

    }else{
      print("百度地图加载失败...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text(""),
        ),
      ),
    );
  }
}
