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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<DataJob>>(
        future: repo.loadAndSort(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final jobs = snapshot.data!;
          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (_, i) {
              final j = jobs[i];
              return ListTile(
                title: Text(j.jobTitle),
                subtitle: Text('${j.companyLocation} • ${j.experienceLevel}'),
                trailing: Text('\$${j.salaryInUsd}'),
              );
            },
          );
        },
      ),
    );
  }
}
