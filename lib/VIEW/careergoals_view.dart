import 'package:final_project/VIEW/uncompletedgoals_view.dart';
import 'package:final_project/VIEW/completedgoals_view.dart';
import 'package:flutter/material.dart';

class CareerGoalsPage extends StatefulWidget {
  @override
  _CareerGoalsPageState createState() => _CareerGoalsPageState();
}

class _CareerGoalsPageState extends State<CareerGoalsPage> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    UncompletedGoalsPage(),
    CompletedGoalsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text("Career Goals")),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Career Goals'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Completed Goals'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}