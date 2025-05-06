import 'package:flutter/material.dart';

import '../../model/filter_jobs_in_data_model.dart';
import '../../presenter/filter_jobs_in_data_presenter.dart';

class FilterJobsInDataView extends StatefulWidget {
  @override
  _FilterJobsInDataViewState createState() => _FilterJobsInDataViewState();
}

//Google Gemini Assisted
class _FilterJobsInDataViewState extends State<FilterJobsInDataView> {
  List<String> _currentItems = [];
  List<double> _currentSalaries = [];
  Map<String, double> _currentData = {};
  final List<String> _filterOptions = ['Countries', 'Company Size', 'Employment Type', 'Experience Level', 'Job Category'];
  String currentFilter = 'Countries';

  late FilterJobsInDataPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = FilterJobsInDataPresenter(
      model: FilterJobsInDataModel(),
      updateViewItemsAndSalaries: (Map<String, double> itemsAndSalaries) {
        setState(() {
          _currentData = itemsAndSalaries;
          _currentItems = _currentData.keys.toList();
          _currentSalaries = _currentData.values.toList();
        });
      },
    );
    _presenter.filterByCountry();
  }

  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Filter by:"),
                  SizedBox(width: 12),
                  DropdownButton<String>(
                    value: currentFilter,
                    onChanged: (String? newValue) {
                      if (newValue == 'Countries') {
                        _presenter.filterByCountry();
                        currentFilter = 'Countries';
                      }
                      if (newValue == 'Company Size') {
                        _presenter.filterByCompanySize();
                        currentFilter = 'Company Size';
                      }
                      if (newValue == 'Employment Type') {
                        _presenter.filterByEmploymentType();
                        currentFilter = 'Employment Type';
                      }
                      if (newValue == 'Experience Level') {
                        _presenter.filterByExperienceLevel();
                        currentFilter = 'Experience Level';
                      }
                      if (newValue == 'Job Category') {
                        _presenter.filterByJobCategory();
                        currentFilter = 'Job Category';
                      }
                    },
                    items: _filterOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _currentItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _currentItems[index],
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _currentSalaries[index].toStringAsFixed(2),
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
    );
  }
}