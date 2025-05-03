import '../model/filter_jobs_in_data_model.dart';

class FilterJobsInDataPresenter{
  FilterJobsInDataPresenter({required this.model, required this.updateViewItemsAndSalaries});
  final FilterJobsInDataModel model;
  final Function(Map<String, double> countriesAndSalaries) updateViewItemsAndSalaries;

  Future<void> filterByCountry() async {
    updateViewItemsAndSalaries(await model.getSalariesByCountry());
  }

  Future<void> filterByCompanySize() async {
    updateViewItemsAndSalaries(await model.getSalariesByCompanySize());
  }


}