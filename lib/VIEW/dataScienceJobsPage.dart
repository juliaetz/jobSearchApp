import 'package:flutter/material.dart';
import '../PRESENTER/load_data.dart';
import '../MODEL/data_read.dart';

class DataScienceJobsPage extends StatefulWidget {
  @override
  _DataScienceJobsPageState createState() => _DataScienceJobsPageState();
}

class _DataScienceJobsPageState extends State<DataScienceJobsPage> {
  final repo = DataJobRepository();
  List<DataJob> jobs = [];

  @override
  void initState() {
    super.initState();
    // Smoke test: load & print the top 5 entries
    repo.loadAndSort().then((list) {
      setState(() => jobs = list);
      for (var j in jobs.take(5)) {
        print('${j.jobTitle} @ ${j.companyLocation}: \$${j.salaryInUsd}');
      }
    }).catchError((e) {
      print('Error loading CSV: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Data Science Careers'),
      ),
      body: jobs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return ListTile(
            title: Text(job.jobTitle),
            subtitle: Text('${job.companyLocation} • ${job.experienceLevel}'),
            trailing: Text('\$${job.salaryInUsd}'),
          );
        },
      ),
    );
  }
}
