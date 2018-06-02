import 'package:flutter/material.dart';
import 'rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:math' as Math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new ClipOval(
                child: new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new Image.network(
                    "https://sfault-avatar.b0.upaiyun.com/206/120/2061206110-5afe2c9d40fa3_huge256",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new ClipRRect(
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                child: new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new Image.network(
                    "https://sfault-avatar.b0.upaiyun.com/206/120/2061206110-5afe2c9d40fa3_huge256",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new ClipRect(
                clipper: new _MyClipper(),
                child: new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new Image.network(
                    "https://sfault-avatar.b0.upaiyun.com/206/120/2061206110-5afe2c9d40fa3_huge256",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new ClipPath(
                clipper: new _StarCliper(radius: 50.0),
                child: new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new Image.network(
                    "https://sfault-avatar.b0.upaiyun.com/206/120/2061206110-5afe2c9d40fa3_huge256",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new StaticRatingBar(
                size: 20.0,
                rate: 4.5,
              ),
              new Row(
                children: <Widget>[
                  new RatingBar(
                    size: 30.0,
                    radiusRatio: 1.4,
                    onChange: (int value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                  new Text("分数${_value}"),
                ],
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}

class _MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTRB(10.0, 10.0, size.width - 10.0, size.height - 10.0);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class _StarCliper extends CustomClipper<Path> {
  final double radius;

  _StarCliper({this.radius});

  /// 角度转弧度公式
  double degree2Radian(int degree) {
    return (Math.pi * degree / 180);
  }

  Path createPath(double radius, Path path) {
    double radian = degree2Radian(36); // 36为五角星的角度
    double radius_in =
        (radius * Math.sin(radian / 2) / Math.cos(radian)); // 中间五边形的半径

    path.moveTo((radius * Math.cos(radian / 2)), 0.0); // 此点为多边形的起点
    path.lineTo((radius * Math.cos(radian / 2) + radius_in * Math.sin(radian)),
        (radius - radius * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) * 2),
        (radius - radius * Math.sin(radian / 2)));
    path.lineTo(
        (radius * Math.cos(radian / 2) + radius_in * Math.cos(radian / 2)),
        (radius + radius_in * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) + radius * Math.sin(radian)),
        (radius + radius * Math.cos(radian)));
    path.lineTo((radius * Math.cos(radian / 2)), (radius + radius_in));
    path.lineTo((radius * Math.cos(radian / 2) - radius * Math.sin(radian)),
        (radius + radius * Math.cos(radian)));
    path.lineTo(
        (radius * Math.cos(radian / 2) - radius_in * Math.cos(radian / 2)),
        (radius + radius_in * Math.sin(radian / 2)));
    path.lineTo(0.0, (radius - radius * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) - radius_in * Math.sin(radian)),
        (radius - radius * Math.sin(radian / 2)));
    return path;
  }

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path = createPath(this.radius / 5, path);
    path = path.shift(new Offset(20.0, 0.0));
    path = createPath(this.radius / 5, path);
    path = path.shift(new Offset(20.0, 0.0));
    path = createPath(this.radius / 5, path);
    path = path.shift(new Offset(20.0, 0.0));
    path = createPath(this.radius / 5, path);
    path = path.shift(new Offset(20.0, 0.0));
    path = createPath(this.radius / 5, path);
    path.close(); // 使这些点构成封闭的多边形

    return path;
  }

  @override
  bool shouldReclip(_StarCliper oldClipper) {
    return this.radius != oldClipper.radius;
  }
}
