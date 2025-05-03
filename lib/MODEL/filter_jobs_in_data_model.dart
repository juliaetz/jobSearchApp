import 'package:final_project/MODEL/data_read.dart';
import 'package:final_project/PRESENTER/load_data.dart';

class FilterJobsInDataModel {
  List<DataJob> jobs = [];
  bool _jobsLoaded = false;
  FilterJobsInDataModel();

  Future<void> initJobs() async {
    final repo = DataJobRepository();
    jobs = await repo.loadAndSort();
    _jobsLoaded = true;
  }

  Future<Map<String, double>> getSalariesByCountry() async {
    if (!_jobsLoaded) {
      await initJobs();
    }
    Map<String, List<int>> salariesByCountry = {};
    for (DataJob job in jobs) {
      if (!salariesByCountry.containsKey(job.companyLocation)) {
        salariesByCountry[job.companyLocation] = [];
      }
      salariesByCountry[job.companyLocation]!.add(job.salaryInUsd);
    }
    Map<String, double> averageSalariesByCountry = {};
    for (String country in salariesByCountry.keys) {
      double totalSalary = 0;
      for (int salary in salariesByCountry[country]!) {
        totalSalary += salary;
      }
      double averageSalaryForCountry = totalSalary / salariesByCountry[country]!.length;
      averageSalariesByCountry[country] = averageSalaryForCountry;
    }
    return averageSalariesByCountry;
  }

  Future<Map<String, double>> getSalariesByCompanySize() async {
    if (!_jobsLoaded) {
      await initJobs();
    }
    Map<String, List<int>> salariesByCompanySize = {};
    for (DataJob job in jobs) {
      if (!salariesByCompanySize.containsKey(job.companySize)) {
        salariesByCompanySize[job.companySize] = [];
      }
      salariesByCompanySize[job.companySize]!.add(job.salaryInUsd);
    }
    Map<String, double> averageSalariesByCompanySize = {};
    for (String companySize in salariesByCompanySize.keys) {
      double totalSalary = 0;
      for (int salary in salariesByCompanySize[companySize]!) {
        totalSalary += salary;
      }
      double averageSalaryForCountry = totalSalary / salariesByCompanySize[companySize]!.length;
      averageSalariesByCompanySize[companySize] = averageSalaryForCountry;
    }
    return averageSalariesByCompanySize;
  }
}