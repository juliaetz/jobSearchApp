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

  filterJobsByCityOrSalary({String? city, String? salaryRange}) {
    return jobs.where((job) {
      final matchesCity = city == null || job.location == city;

      final salary = job.avgSalary ?? 0;
      bool matchesSalary = true;
      if (salaryRange != null) {
        if (salaryRange == '< \$50k') {
          matchesSalary = salary < 50000;
        } else if (salaryRange == '\$50k - \$100k') {
          matchesSalary = salary >= 50000 && salary <= 100000;
        } else if (salaryRange == '\$100k - \$150k') {
          matchesSalary = salary > 100000 && salary <= 150000;
        } else if (salaryRange == '> \$150k') {
          matchesSalary = salary > 150000;
        }
      }

      return matchesCity && matchesSalary;
    }).toList();
  }
}