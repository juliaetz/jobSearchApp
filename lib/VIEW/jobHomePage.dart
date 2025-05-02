import 'package:flutter/material.dart';

class JobHomePage extends StatelessWidget{
  @override
  _JobHomePageState createState() => _JobHomePageState();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to your Job Search!"),
          ],
        ),
      ),




    );
  }
}

class _JobHomePageState extends JobHomePage{

}