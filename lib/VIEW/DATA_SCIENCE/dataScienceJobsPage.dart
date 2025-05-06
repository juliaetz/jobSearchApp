import 'package:flutter/material.dart';
import '../../PRESENTER/load_data.dart';
import '../../MODEL/data_read.dart';
import 'filter_jobs_in_data_view.dart';
import 'package:final_project/VIEW/Data_SCIENCE/dataSci_job_search_tab.dart';

class DataScienceJobsPage extends StatefulWidget {
  @override
  _DataScienceJobsPageState createState() => _DataScienceJobsPageState();
}


class _DataScienceJobsPageState extends State<DataScienceJobsPage> {
  final repo = DataJobRepository();
  List<DataJob> jobs = [];
  String? loadError;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    repo.loadAndSort()
        .then((list) => setState(() => jobs = list))
        .catchError((e) => setState(() => loadError = e.toString()));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions() {
    return [
      DataSciJobSearchTab(allJobs: jobs),
      FilterJobsInDataView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (loadError != null) {
      content = Center(child: Text('Error: $loadError'));
    } else if (jobs.isEmpty) {
      content = Center(child: CircularProgressIndicator());
    } else {
      content = _widgetOptions()[_selectedIndex];
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text("Data Science Careers")),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
