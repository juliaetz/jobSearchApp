// import 'package:final_project/MODEL/data_read.dart';
// import 'package:final_project/PRESENTER/load_data.dart';
//
// class FilterJobsInDataModel {
//   List<Job> jobs = [];
//   bool _jobsLoaded = false;
//   FilterJobsInDataModel();
//
//   Future<void> initJobs() async {
//     final repo = JobRepository();
//     jobs = await repo.loadAndSort();
//     _jobsLoaded = true;
//   }
//
//   Future<Map<String, double>> getSalariesByCountry() async {
//     if (!_jobsLoaded) {
//       await initJobs();
//     }
//     Map<String, List<double>> salariesByCountry = {};
//     for (Job job in jobs) {
//       if (!salariesByCountry.containsKey(job.country)) {
//         salariesByCountry[job.country] = [];
//       }
//       salariesByCountry[job.country].add(job.salary);
//     }
//     Map<String, double> averageSalariesByCountry = {};
//     for (String country in salariesByCountry.keys) {
//       double totalSalary = 0;
//       for (double salary in salariesByCountry[country]!) {
//         totalSalary += salary;
//       }
//       double averageSalaryForCountry = totalSalary / salariesByCountry[country]!.length;
//       averageSalariesByCountry[country] = averageSalaryForCountry;
//     }
//     return averageSalariesByCountry;
//   }
//
//   Future<Map<String, double>> getSalariesByCompanySize() async {
//     if (!_jobsLoaded) {
//       await initJobs();
//     }
//     Map<String, List<double>> salariesByCompanySize = {};
//     for (Job job in jobs) {
//       if (!salariesByCompanySize.containsKey(job.companySize)) {
//         salariesByCompanySize[job.companySize] = [];
//       }
//       salariesByCompanySize[job.companySize].add(job.salary);
//     }
//     Map<String, double> averageSalariesByCompanySize = {};
//     for (String companySize in salariesByCompanySize.keys) {
//       double totalSalary = 0;
//       for (double salary in salariesByCompanySize[companySize]!) {
//         totalSalary += salary;
//       }
//       double averageSalaryForCompanySize = totalSalary / salariesByCompanySize[companySize]!.length;
//       averageSalariesByCompanySize[companySize] = averageSalaryForCompanySize;
//     }
//     return averageSalariesByCompanySize;
//   }
// }