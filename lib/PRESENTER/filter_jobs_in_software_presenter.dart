import 'package:final_project/PRESENTER/load_data.dart';
import '../MODEL/data_read.dart';
import '../MODEL/filter_jobs_in_software_model.dart';


class FilterJobsInSoftwarePresenter {
  final FilterJobsInSoftwareModel model;
  final void Function(Map<String, double>) updateViewItemsAndSalaries;

  FilterJobsInSoftwarePresenter({
    required this.model,
    required this.updateViewItemsAndSalaries,
  });

  /// Ensures jobs are loaded, then computes and sorts avg salary per city
  Future<void> filterByCity() async {
    await model.initJobs();
    // compute the raw averages
    final data = model.averageSalaryByCity();

    // sort cities by descending average salary
    final sortedEntries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // rebuild a map in sorted order
    final sortedMap = {
      for (final entry in sortedEntries) entry.key: entry.value,
    };

    updateViewItemsAndSalaries(sortedMap);
  }
}

