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
    averageSalariesByCountry = sortBySalary(averageSalariesByCountry);
    return averageSalariesByCountry;
  }

  Future<Map<String, double>> getSalariesByExperienceLevel() async {
    if (!_jobsLoaded) {
      await initJobs();
    }
    Map<String, List<int>> salariesByExperienceLevel = {};
    for (DataJob job in jobs) {
      if (!salariesByExperienceLevel.containsKey(job.experienceLevel)) {
        salariesByExperienceLevel[job.experienceLevel] = [];
      }
      salariesByExperienceLevel[job.experienceLevel]!.add(job.salaryInUsd);
    }
    Map<String, double> averageSalariesByExperienceLevel = {};
    for (String experienceLevel in salariesByExperienceLevel.keys) {
      double totalSalary = 0;
      for (int salary in salariesByExperienceLevel[experienceLevel]!) {
        totalSalary += salary;
      }
      double averageSalaryForCountry = totalSalary / salariesByExperienceLevel[experienceLevel]!.length;
      averageSalariesByExperienceLevel[experienceLevel] = averageSalaryForCountry;
    }
    averageSalariesByExperienceLevel = sortBySalary(averageSalariesByExperienceLevel);
    return averageSalariesByExperienceLevel;
  }

  Future<Map<String, double>> getSalariesByJobCategory() async {
    if (!_jobsLoaded) {
      await initJobs();
    }
    Map<String, List<int>> salariesByJobCategory = {};
    for (DataJob job in jobs) {
      if (!salariesByJobCategory.containsKey(job.jobCategory)) {
        salariesByJobCategory[job.jobCategory] = [];
      }
      salariesByJobCategory[job.jobCategory]!.add(job.salaryInUsd);
    }
    Map<String, double> averageSalariesByJobCategory = {};
    for (String jobCategory in salariesByJobCategory.keys) {
      double totalSalary = 0;
      for (int salary in salariesByJobCategory[jobCategory]!) {
        totalSalary += salary;
      }
      double averageSalaryForCountry = totalSalary / salariesByJobCategory[jobCategory]!.length;
      averageSalariesByJobCategory[jobCategory] = averageSalaryForCountry;
    }
    averageSalariesByJobCategory = sortBySalary(averageSalariesByJobCategory);
    return averageSalariesByJobCategory;
  }

  Future<Map<String, double>> getSalariesByEmploymentType() async {
    if (!_jobsLoaded) {
      await initJobs();
    }
    Map<String, List<int>> salariesByEmploymentType = {};
    for (DataJob job in jobs) {
      if (!salariesByEmploymentType.containsKey(job.employmentType)) {
        salariesByEmploymentType[job.employmentType] = [];
      }
      salariesByEmploymentType[job.employmentType]!.add(job.salaryInUsd);
    }
    Map<String, double> averageSalariesByEmploymentType = {};
    for (String employmentType in salariesByEmploymentType.keys) {
      double totalSalary = 0;
      for (int salary in salariesByEmploymentType[employmentType]!) {
        totalSalary += salary;
      }
      double averageSalaryForCountry = totalSalary / salariesByEmploymentType[employmentType]!.length;
      averageSalariesByEmploymentType[employmentType] = averageSalaryForCountry;
    }
    averageSalariesByEmploymentType = sortBySalary(averageSalariesByEmploymentType);
    return averageSalariesByEmploymentType;
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
    Map<String, String> companySizeMap = {
      "S": "Small",
      "M": "Medium",
      "L": "Large",
    };
    averageSalariesByCompanySize = Map.fromEntries(
        averageSalariesByCompanySize.entries
            .map((e) => MapEntry(companySizeMap[e.key] ?? e.key, e.value)));

    averageSalariesByCompanySize = sortBySalary(averageSalariesByCompanySize);
    return averageSalariesByCompanySize;
  }

  Map<String, double> sortBySalary(Map<String, double> itemsAndSalaries) {
    return Map.fromEntries(itemsAndSalaries.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));
  }
}