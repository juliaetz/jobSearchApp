import 'package:flutter/material.dart';
import 'package:final_project/VIEW/DATA_SCIENCE/dataScienceJobsPage.dart';
import '../../MODEL/data_read.dart';


/*
to search for a job category according to a selected work setting and as a
result, see the job title, company location, employment type, and salary
 */

class DataSciJobSearchTab extends StatefulWidget {
  final List<DataJob> allJobs;

  const DataSciJobSearchTab({Key? key, required this.allJobs}) : super(key: key);

  @override
  _DataSciJobSearchTabState createState() => _DataSciJobSearchTabState();
}

class _DataSciJobSearchTabState extends State<DataSciJobSearchTab>{
  late List<DataJob> filteredJobs;

  @override
  void initState() {
    super.initState();
    filteredJobs = widget.allJobs;
  }

  void _filterJobs(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredJobs = widget.allJobs.where((job) {
        return job.workSetting.toLowerCase().contains(q);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          // TEXT FIELD (SEARCH BAR)
          child: TextField(
            onChanged: _filterJobs,
            decoration: InputDecoration(
              hintText: 'Search by title, company, location, salary...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),

        // DISPLAY JOB INFORMATION
        Expanded(
            child: ListView.builder(
                itemCount: filteredJobs.length,
                itemBuilder: (_, i){
                  final job = filteredJobs[i];
                  return ListTile(
                    title: Text(job.jobTitle),
                    subtitle: Text('${job.companyLocation} • ${job.employmentType}'),
                    trailing: Text('\$${job.salary}'),
                  );
                }
            )
        )


      ],
    );
  }
}
