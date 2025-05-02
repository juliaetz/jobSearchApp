import 'package:flutter/material.dart';

class DataScienceJobsPage extends StatelessWidget{
  @override
  _DataScienceJobsPageState createState() => _DataScienceJobsPageState();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Row(
            children: <Widget>[
              Text("Data Science Careers"),
            ],
          )
      ),
    );
  }
}

class _DataScienceJobsPageState {
}