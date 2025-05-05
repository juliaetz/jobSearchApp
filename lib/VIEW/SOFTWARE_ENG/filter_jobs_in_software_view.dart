import 'package:flutter/material.dart';
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
  List<String> _cities = [];
  List<double> _averages = [];

  @override
  void initState() {
    super.initState();
    _presenter = FilterJobsInSoftwarePresenter(
      model: _model,
      updateViewItemsAndSalaries: (data) {
        setState(() {
          _cities = data.keys.toList();
          _averages = data.values.toList();
        });
      },
    );
    _presenter.filterByCity();
  }

  @override
  Widget build(BuildContext context) {
    if (_cities.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _cities.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_cities[index]),
          trailing: Text('\$${_averages[index].toStringAsFixed(0)}'),
        );
      },
    );
  }
}