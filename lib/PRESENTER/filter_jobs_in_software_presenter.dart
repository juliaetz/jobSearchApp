import 'package:final_project/PRESENTER/load_data.dart';
import '../MODEL/data_read.dart';
import '../MODEL/filter_jobs_in_software_model.dart';
import 'package:flutter/material.dart';

class FilterJobsInSoftwarePresenter {
  final FilterJobsInSoftwareModel model;
  final void Function(List<Job>) updateViewItemsAndSalaries;

  FilterJobsInSoftwarePresenter({
    required this.model,
    required this.updateViewItemsAndSalaries,
  });

  Future<void> filterByCityOrSalary({
    String? city,
    String? salaryRange,

  }) async {
    await model.initJobs();

    // GET FILTERED JOBS BASED ON CITY AND SALARY RANGE
    final filteredJobs = model.filterJobsByCityOrSalary(city: city, salaryRange: salaryRange);

    // UPDATE VIEW
    updateViewItemsAndSalaries(filteredJobs);
}



// PARSE SALARY RANGES
  RangeValues _parseSalaryRange(String range) {
    switch (range) {
      case '< \$50k':
        return const RangeValues(0, 50000);
      case '\$50k - \$100k':
        return const RangeValues(50000, 100000);
      case '\$100k - \$150k':
        return const RangeValues(100000, 150000);
      case '> \$150k':
        return const RangeValues(150000, double.infinity);
      default:
        return const RangeValues(0, double.infinity);
    }
  }
}
