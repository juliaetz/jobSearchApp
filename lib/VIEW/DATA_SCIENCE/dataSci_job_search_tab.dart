import 'package:flutter/material.dart';
import '../../MODEL/data_read.dart';
import '../../PRESENTER/dataScienceJobs_presenter.dart';


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
  String workSetting = "Any";
  Map<DataJob,int> originalIndex = <DataJob,int>{};
  Map<int,bool> _isFavorited = <int,bool>{};
  bool _isLoading = true;

  late DataJobsPresenter presenter;

  @override
  void initState() {
    super.initState();
    filteredJobs = widget.allJobs;

    int index = 0;
    for(DataJob j in widget.allJobs){
      originalIndex[j] = index;
      index++;
    }

    presenter = DataJobsPresenter();
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
        final matchesSearchQuery = job.jobCategory.toLowerCase().contains(q);

        final matchesWorkSetting = workSetting == 'Any' ||
            job.workSetting.toLowerCase() == workSetting.toLowerCase();

        return matchesSearchQuery && matchesWorkSetting;
      }).toList();
    });
  }

  void _filterWorkSetting(String? query) {
    setState(() {
      workSetting = query ?? 'Any';
      _filterJobs('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          //Search Bar for job category
          child: TextField(
            onChanged: _filterJobs,
            decoration: InputDecoration(
              hintText: 'Search by Job Category: e.g "Data Analysis"',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),

        //Dropdown to pick the work setting
        Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Work Setting: '),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: workSetting,
                  onChanged: _filterWorkSetting,
                  items: <String>['Any', 'Remote', 'In-person', 'Hybrid']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ]
            )
        ),

        // DISPLAY JOB INFORMATION
        Expanded(
            child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
                itemCount: filteredJobs.length,
                itemBuilder: (_, i){
                  final job = filteredJobs[i];
                  return ListTile(
                    title: Text('${job.jobTitle} • \$${job.salary}'),
                    subtitle: Text('${job.companyLocation} • ${job.employmentType}'),
                    //trailing: Text('\$${job.salary}'),
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
