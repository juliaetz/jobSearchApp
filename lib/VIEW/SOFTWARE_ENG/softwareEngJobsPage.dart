import 'package:final_project/VIEW/SOFTWARE_ENG/filter_jobs_in_software_view.dart';
import 'package:flutter/material.dart';
import '../../PRESENTER/load_data.dart';
import '../../MODEL/data_read.dart';
import 'software_job_search_tab.dart';


class SoftwareEngJobsPage extends StatefulWidget {
  @override
  _SoftwareEngJobsPageState createState() => _SoftwareEngJobsPageState();
}

class _SoftwareEngJobsPageState extends State<SoftwareEngJobsPage> {
  final repo = JobRepository();
  List<Job> jobs = [];
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
        // 1) List view
        ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (_, i) {
            final j = jobs[i];
            return ListTile(
              title: Text(j.title),
              subtitle: Text('${j.company} • ${j.location}'),
              trailing: Text('\$${j.avgSalary}'),
            );
          },
        ),
        // 2) Filter by location/company
        FilterJobsInSoftwareView(),
        // 3) Search
        JobSearchTab(allJobs: jobs),
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
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
