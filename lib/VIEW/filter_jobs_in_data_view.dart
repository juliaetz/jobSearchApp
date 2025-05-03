import 'package:flutter/material.dart';

import '../model/filter_jobs_in_data_model.dart';
import '../presenter/filter_jobs_in_data_presenter.dart';

class FilterJobsInDataView extends StatefulWidget {
  @override
  _FilterJobsInDataViewState createState() => _FilterJobsInDataViewState();
}

//Google Gemini Assisted
class _FilterJobsInDataViewState extends State<FilterJobsInDataView> {
  String _selectedFilter = 'Countries';
  List<String> _currentItems = [];
  List<double> _currentSalaries = [];
  Map<String, double> _currentData = {};

  final List<String> _filterOptions = ['Countries', 'Company Size'];

  // late FilterJobsInDataPresenter _presenter;
  final Map<String, double> _countriesAndSalaries = {
    'USA': 100000.0,
    'Canada': 80000.0,
  };
  List<String> countries = [];
  List<double> salaries = [];
  final Map<String, double> _companySizesAndSalaries = {
    'Small': 50000.0,
    'Medium': 80000.0,
    'Large': 120000.0,
  };
  List<String> companySizes = [];
  List<double> companySalaries = [];

  @override
  void initState() {
    super.initState();
    print("init");
    setState(() {
      countries = _countriesAndSalaries.keys.toList();
      salaries = _countriesAndSalaries.values.toList();
      companySizes = _companySizesAndSalaries.keys.toList();
      companySalaries = _companySizesAndSalaries.values.toList();
      _currentItems = countries;
      _currentSalaries = salaries;
      _currentData = _countriesAndSalaries;
    });
    // _presenter = FilterJobsInDataPresenter(
    //   model: FilterJobsInDataModel(),
    //   updateViewCountriesAndSalaries: (Map<String, double> countriesAndSalaries) {
    //     setState(() {
    //       _countriesAndSalaries = countriesAndSalaries;
    //       countries = _countriesAndSalaries.keys.toList();
    //       salaries = _countriesAndSalaries.values.toList();
    //     });
    // });
  }

  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _selectedFilter,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFilter = newValue!;
                    _currentData = _selectedFilter == 'Countries'
                        ? _countriesAndSalaries
                        : _companySizesAndSalaries;
                    _currentItems = _currentData.keys.toList();
                    _currentSalaries = _currentData.values.toList();
                  });
                },
                items: _filterOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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