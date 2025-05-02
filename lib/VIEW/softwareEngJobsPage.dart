import 'package:flutter/material.dart';

class SoftwareEngJobsPage extends StatelessWidget{
  @override
  _SoftwareEngJobsPageState createState() => _SoftwareEngJobsPageState();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: <Widget>[
            Text("Software Engineering Careers"),
          ],
        )
      ),
    );
  }
}

class _SoftwareEngJobsPageState {
}