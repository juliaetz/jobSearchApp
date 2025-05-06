import 'package:final_project/VIEW/SOFTWARE_ENG/filter_jobs_in_software_view.dart';
import 'package:flutter/material.dart';
import '../../PRESENTER/load_data.dart';
import '../../MODEL/data_read.dart';
import 'software_job_search_tab.dart';
import '../../PRESENTER/softwareJobs_presenter.dart';


class SoftwareEngJobsPage extends StatefulWidget {
  @override
  _SoftwareEngJobsPageState createState() => _SoftwareEngJobsPageState();
}

class _SoftwareEngJobsPageState extends State<SoftwareEngJobsPage> {
  final repo = JobRepository();
  List<Job> jobs = [];
  String? loadError;
  int _selectedIndex = 0;

  late SoftwareJobsPresenter presenter;

  @override
  void initState() {
    super.initState();

    presenter = SoftwareJobsPresenter();

    repo.loadAndSort()
        .then((list) => setState(() => jobs = list))
        .catchError((e) => setState(() => loadError = e.toString()));
  }
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (loadError != null) {
      content = Center(child: Text('Error: $loadError'));
    } else if (jobs.isEmpty) {
      content = Center(child: CircularProgressIndicator());
    } else {
      // Define your tabs here:
      final tabs = <Widget>[
        // 1) Search
        SoftEngJobSearchTab(allJobs: jobs),
        // 2) Filter by city
        FilterJobsInSoftwareView(),
      ];
      content = tabs[_selectedIndex];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Software Engineering Careers'),
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
        ],
      ),
    );
  }
}
