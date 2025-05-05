import 'package:final_project/PRESENTER/load_data.dart';
import 'package:flutter/material.dart';
import '../../MODEL/data_read.dart';
import 'software_job_search_tab.dart';

int _selectedIndex = 0;

class SoftwareEngJobsPage extends StatefulWidget{
  @override
  _SoftwareEngJobsPageState createState() => _SoftwareEngJobsPageState();

}


// TEMPORARY TO DISPLAY DATA ON PAGE, MODIFY THIS FOR FILTERING!

class _SoftwareEngJobsPageState extends State<SoftwareEngJobsPage>{
  final repo = JobRepository();
  List<Job> jobs = [];

  @override
  void initState() {
    super.initState();
    repo.loadAndSort().then((list) {
      setState(() => jobs = list);
      for (var j in jobs.take(5)) {
        print('${j.title} @ ${j.company}, ${j.location}: \$${j.avgSalary}');
      }
    });
  }


  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    if(_selectedIndex == 2){
      return JobSearchTab(allJobs: jobs);
    }
    else {
      return ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (_, i){
          final j = jobs[i];
          return ListTile(
            title: Text(j.title),
            subtitle: Text('${j.company} • ${j.location}'),
            trailing: Text('\$${j.avgSalary}'),
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // later: build ListView, add search/filter, compare by city, …
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text('Software Engineering Careers')),

    body: _buildBody(),

    bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),

    );
  }



}