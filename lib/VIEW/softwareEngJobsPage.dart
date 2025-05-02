import 'package:final_project/PRESENTER/load_data.dart';
import 'package:flutter/material.dart';
import '../MODEL/data_read.dart';


class SoftwareEngJobsPage extends StatefulWidget{
  @override
  _SoftwareEngJobsPageState createState() => _SoftwareEngJobsPageState();

}



// TESTED DATA DISPLAY ON THIS PAGE... CHANGE THIS

class _SoftwareEngJobsPageState extends State<SoftwareEngJobsPage>{
  final repo = JobRepository();
  List<Job> jobs = [];

  @override
  void initState() {
    super.initState();
    repo.loadAndSort().then((list) {
      setState(() => jobs = list);
      // for now, just print top 5:
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
        //DELETE ABOVE ^^^^^^^^
      ),
    );
  }
}