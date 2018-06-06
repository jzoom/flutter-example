import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBaiduMap {
  static const MethodChannel _channel =
      const MethodChannel('flutter_baidu_map');



  static Future<dynamic> startLocation() async{
    return await _channel.invokeMethod("startLocation");
  }

  static Future<bool> init() async {
    _channel.setMethodCallHandler(handler);  //注意这里需要设置一下监听函数
    return await _channel.invokeMethod('init');
  }
  static StreamController<Map> _locationUpdateStreamController = new StreamController.broadcast();
  static Stream<Map> get locationUpdate=>_locationUpdateStreamController.stream;

  static Future<dynamic> handler(MethodCall call) {
    String method = call.method;

    switch (method) {
      case "onLocation":
        {
          _locationUpdateStreamController.add( call.arguments );
        }
        break;
    }
    return new Future.value("");
  }
}
