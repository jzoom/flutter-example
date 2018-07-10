import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment }
// The reducer, which takes the previous count and increments it in response
// to an Increment action.
int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }

  return state;
}



void main(){
  Store<int> store = new Store<int>(counterReducer, initialState: 0);
  runApp(new MyApp(store: store,));
}

class MyApp extends StatelessWidget {

  final Store<int> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(store: store, child: new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new StoreConnector<int,String>(builder: (BuildContext context,String counter){
        return new MyHomePage(title: 'Flutter Demo Home Page',counter: counter,);
      },converter: (Store<int> store){
        return store.state.toString();
      },),
    ));
  }
}

class MyHomePage extends StatelessWidget {
  final String counter;

  MyHomePage({Key key, this.title,this.counter}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(""),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new StoreConnector<int,VoidCallback>(builder: (BuildContext context,VoidCallback callback){
        return new FloatingActionButton(
          onPressed: callback,
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        );
      }, converter: (Store<int> store){
        return ()=>store.dispatch(Actions.Increment);
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
