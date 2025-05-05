import 'package:flutter/material.dart';
import '../../MODEL/data_read.dart';

/*
to search for a job title from the database and see the company name, location,
and salary as a result
 */


class SoftEngJobSearchTab extends StatefulWidget{
  final List<Job> allJobs;

  const SoftEngJobSearchTab({Key? key, required this.allJobs}) : super(key: key);

  @override
  _SoftEngJobSearchTabState createState() => _SoftEngJobSearchTabState();
}

class _SoftEngJobSearchTabState extends State<SoftEngJobSearchTab> {
  late List<Job> filteredJobs;

  @override
  void initState() {
    super.initState();
    filteredJobs = widget.allJobs;
  }

  void _filterJobs(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredJobs = widget.allJobs.where((job) {
        return job.title.toLowerCase().contains(q) ||
            job.company.toLowerCase().contains(q) ||
            job.location.toLowerCase().contains(q) ||
            job.avgSalary.toString().contains(q) ||
            job.datePosted.toLowerCase().contains(q) ||
            job.companyScore.toString().contains(q);
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
                title: Text(job.title),
                subtitle: Text('${job.company} • ${job.location}'),
                trailing: Text('\$${job.avgSalary}'),
              );
            }
          )
        )


      ],
    );
  }


}