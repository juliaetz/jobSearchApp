import 'package:flutter/material.dart';
import '../../MODEL/data_read.dart';
import '../../MODEL/filter_jobs_in_software_model.dart';
import '../../PRESENTER/filter_jobs_in_software_presenter.dart';

class FilterJobsInSoftwareView extends StatefulWidget {
  const FilterJobsInSoftwareView({Key? key}) : super(key: key);

  @override
  _FilterJobsInSoftwareViewState createState() =>
      _FilterJobsInSoftwareViewState();
}

class _FilterJobsInSoftwareViewState extends State<FilterJobsInSoftwareView> {
  final _model = FilterJobsInSoftwareModel();
  late final FilterJobsInSoftwarePresenter _presenter;

  List<Job> _filteredJobs = [];
  List<String> _cities = [];

  // DROP DOWN SELECTIONS
  String? _selectedCity;
  String? _selectedSalaryRange;
  final List<String> salaryRanges = ['< \$50k', '\$50k - \$100k', '\$100k - \$150k', '> \$150k'];

  @override
  void initState() {
    super.initState();
    _presenter = FilterJobsInSoftwarePresenter(
      model: _model,
      updateViewItemsAndSalaries: (filteredJobs) {
        setState(() {
          _filteredJobs = filteredJobs;
          print("Filtered jobs count: ${_filteredJobs.length}");
        });
      },
    );

    _model.initJobs().then((_) {
      print("Jobs loaded: ${_model.jobs.length}");
      setState(() {
        _cities = _model.jobs.map((j) => j.location ?? '').toSet().toList();
      });
      _applyFilters();
    });
  }

  void _applyFilters() {
    _presenter.filterByCityOrSalary(
      city: _selectedCity,
      salaryRange: _selectedSalaryRange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  hint: Text("Filter by City"),
                  value: _selectedCity,
                  isExpanded: true,
                  items: _cities.map((city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  hint: Text("Filter by Salary"),
                  value: _selectedSalaryRange,
                  isExpanded: true,
                  items: salaryRanges.map((range) {
                    return DropdownMenuItem(value: range, child: Text(range));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSalaryRange = value;
                    });
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _filteredJobs.isEmpty
              ? Center(child: Text("No jobs match your filters."))
              : ListView.builder(
            itemCount: _filteredJobs.length,
            itemBuilder: (context, index) {
              final job = _filteredJobs[index];
              return ListTile(
                title: Text(job.title),
                subtitle: Text('${job.company} • ${job.location}'),
                trailing: Text('\$${job.avgSalary?.toStringAsFixed(0) ?? 'N/A'}'),
              );
            },
          ),
        ),
      ],
    );
  }
}


