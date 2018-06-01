import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

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
  @override
  Widget build(BuildContext context) {
    SvgPicture close = new SvgPicture.asset(
      "assets/close.svg",
      color: Colors.grey,
    );
    SvgPicture set =
        new SvgPicture.asset("assets/set.svg", color: Colors.redAccent);
    SvgPicture warning =
        new SvgPicture.asset("assets/warning.svg", color: Colors.blueAccent);
    SvgPicture wrong =
        new SvgPicture.asset("assets/wrong.svg", color: Colors.greenAccent);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new SizedBox(
                width: 50.0,
                height: 50.0,
                child: close,
              ),
              new SizedBox(
                width: 50.0,
                height: 50.0,
                child: set,
              ),
              new SizedBox(
                width: 50.0,
                height: 50.0,
                child: warning,
              ),
              new SizedBox(
                width: 50.0,
                height: 50.0,
                child: wrong,
              ),
            ],
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
