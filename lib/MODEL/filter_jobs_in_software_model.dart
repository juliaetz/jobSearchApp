import 'package:final_project/MODEL/data_read.dart';
import 'package:final_project/PRESENTER/load_data.dart';

class FilterJobsInSoftwareModel {
  List<Job> jobs = [];
  bool _jobsLoaded = false;

  /// Loads all jobs once and caches them.
  Future<void> initJobs() async {
    if (!_jobsLoaded) {
      final repo = JobRepository();
      jobs = await repo.loadAndSort();
      _jobsLoaded = true;
    }
  }

  /// Returns a map of city → average salary.
  Map<String, double> averageSalaryByCity() {
    final byCity = <String, List<int>>{};
    for (var job in jobs) {
      byCity.putIfAbsent(job.location, () => []).add(job.avgSalary);
    }
    return byCity.map((city, list) {
      final avg = list.fold<int>(0, (sum, s) => sum + s) / list.length;
      return MapEntry(city, avg);
    });
  }
}