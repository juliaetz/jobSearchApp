import 'package:flutter/material.dart';
import 'filter_jobs_in_data_view.dart';

class DataScienceJobsPage extends StatefulWidget{
  @override
  _DataScienceJobsPageState createState() => _DataScienceJobsPageState();
}

//Google Gemini Created
class _DataScienceJobsPageState  extends State<DataScienceJobsPage>{

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
    FilterJobsInDataView(),
    Text("SearchJobsInDataViewHere"),
  ];

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
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}