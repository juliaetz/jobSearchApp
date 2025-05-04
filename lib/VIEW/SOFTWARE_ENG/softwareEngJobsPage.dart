import 'package:final_project/PRESENTER/load_data.dart';
import 'package:flutter/material.dart';
import '../../MODEL/data_read.dart';


class SoftwareEngJobsPage extends StatefulWidget{
  @override
  _SoftwareEngJobsPageState createState() => _SoftwareEngJobsPageState();

}

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

  @override
  Widget build(BuildContext context) {
    // later: build ListView, add search/filter, compare by city, …
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text('Software Engineering Careers')),
      body: ListView.builder(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        //currentIndex: _selectedIndex,
        //onTap: _onItemTapped,
      ),

    );
  }



}