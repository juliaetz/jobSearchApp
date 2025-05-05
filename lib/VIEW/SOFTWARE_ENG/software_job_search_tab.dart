import 'package:flutter/material.dart';
import '../../MODEL/data_read.dart';
import '../../PRESENTER/softwareJobs_presenter.dart';

/*
to search for a job title from the database and see the company name, location,
and salary as a result
 */


class JobSearchTab extends StatefulWidget{
  final List<Job> allJobs;

  const JobSearchTab({Key? key, required this.allJobs}) : super(key: key);

  @override
  _JobSearchTabState createState() => _JobSearchTabState();
}

class _JobSearchTabState extends State<JobSearchTab> {
  late List<Job> filteredJobs;
  Map<Job,int> originalIndex = <Job,int>{};
  Map<int,bool> _isFavorited = <int,bool>{};
  bool _isLoading = true;

  late SoftwareJobsPresenter presenter;

  @override
  void initState() {
    super.initState();
    filteredJobs = widget.allJobs;

    int index = 0;
    for(Job j in widget.allJobs){
      originalIndex[j] = index;
      index++;
    }

    presenter = SoftwareJobsPresenter();
    initData();
  }

  void initData() async {
    _isFavorited = await presenter.setMaps();
    setState(() {
      _isLoading = false;
    });
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
              child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
                  itemCount: filteredJobs.length,
                  itemBuilder: (_, i) {
                    final job = filteredJobs[i];
                    return ListTile(
                      //title: Text(job.title),
                      title: Text('${job.title} • \$${job.avgSalary}'),
                      subtitle: Text('${job.company} • ${job.location}'),
                      //trailing: Text('\$${job.avgSalary}'),
                      trailing: IconButton(
                        onPressed: () {
                          updateData() async {
                            _isFavorited = await presenter.updateFavoriteData(
                                originalIndex[job]!, job);
                          }

                          setState(() {
                            updateData();
                          });
                        },
                        icon: Icon(
                          (_isFavorited[originalIndex[job!]] == true ? Icons.favorite : Icons
                              .favorite_border), color: Colors.green.shade700,
                          size: 30.0,),
                      ),
                    );
                  }
              )
          )


        ],
      );
    }
}