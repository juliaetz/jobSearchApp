import 'package:final_project/PRESENTER/load_data.dart';
import '../MODEL/data_read.dart';


class SoftwareEngPresenter{
  final JobRepository repo;

  SoftwareEngPresenter({required this.repo});

  Future<List<Job>> searchJobs(String query) async{
    final allJobs = await repo.loadAndSort();
    final q = query.toLowerCase();

    return allJobs.where((job){
      return job.title.toLowerCase().contains(q) ||
          job.company.toLowerCase().contains(q) ||
          job.location.toLowerCase().contains(q) ||
          job.avgSalary.toString().contains(q) ||
          job.datePosted.toLowerCase().contains(q) ||
          job.companyScore.toString().contains(q);
    }).toList();
  }


}