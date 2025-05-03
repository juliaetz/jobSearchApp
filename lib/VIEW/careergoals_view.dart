import 'package:final_project/MODEL/careergoals_model.dart';
import 'package:final_project/PRESENTER/careergoals_presenter.dart';
import 'package:flutter/material.dart';

class CareerGoalsPage extends StatefulWidget {
  const CareerGoalsPage({Key? key}) : super(key: key);
  @override
  _CareerGoalsPageState createState() => _CareerGoalsPageState();
}

class _CareerGoalsPageState extends State<CareerGoalsPage> {


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Career Goals"),
      ),
    );
  }
}