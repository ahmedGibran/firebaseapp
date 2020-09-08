import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Welcome",textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).primaryColor),),
      ),
    );
  }
}
