import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_use_redux/reducers.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';


typedef Future CallLogin(String account,String pwd);

class LoginPageState extends State<LoginPage>{

  String _account;
  String _pwd;



  bool isLogin;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("登录"),
      ),
      body: new Form(
          onChanged: (){
            print("changed");
          },
          onWillPop: () async{
            return true;
          },
          child: new Padding(padding: new EdgeInsets.all(10.0),child: new Column(

            children: <Widget>[
              new TextFormField( decoration:new InputDecoration(labelText: "请输入账号") ,
                onSaved: (String value){
                 _account = value;
                },  ///保持一下输入的账号
                validator: (String value)=> value.isEmpty ? "请输入账号" : null, ),
              new TextFormField(decoration:new InputDecoration(labelText: "请输入密码"),
                  onSaved: (String value)=>_pwd = value, ///保持一下输入的密码
                  validator: (String value)=> value.isEmpty ? "请输入密码" : null),
              new FormField(builder: (FormFieldState s){
                return new Center(
                  child: new RaisedButton(onPressed: () async{

                  FormState state = Form.of(s.context);
                  if(state.validate()){
                    //如果验证成功，那么执行登录逻辑
                    state.save();
                    print("Login success $_account" );
                    //这里交给设置好的逻辑去执行操作
                    try{
                      await widget.callLogin(_account,_pwd);
                      showDialog(context: context,builder: (c){

                        return new CupertinoAlertDialog(
                          title: new Text("登录成功"),
                          actions: <Widget>[
                            new Center(
                              child: new RaisedButton(
                                onPressed:(){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: new Text("ok"),
                              )
                            )
                          ],
                        );

                      });
                    //  Navigator.of(context).pop();
                    }catch(e){
                      showDialog(context: context,builder: (c){

                        return new CupertinoAlertDialog(
                          title: new Text("登录失败$e"),
                          actions: <Widget>[
                            new Center(
                                child: new RaisedButton(
                                  onPressed:(){
                                    Navigator.of(context).pop();
                                  },
                                  child: new Text("ok"),
                                )
                            )
                          ],
                        );

                      });
                      ///登录失败，提示一下用户
                      print("登录失败! $e");
                    }

                  }

                },child: new Text("提交"),)
                );
              })
            ],

          ),)),
    );
  }

}

class LoginPage extends StatefulWidget{

  CallLogin callLogin;


  LoginPage({this.callLogin});

  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }



}