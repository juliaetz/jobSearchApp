import 'package:flutter/material.dart';

import '../model/filter_data_science_model.dart';
import '../presenter/filter_data_science_presenter.dart';

class FilterDataScienceView extends StatefulWidget {
  @override
  _FilterDataScienceViewState createState() => _FilterDataScienceViewState();
}

class _FilterDataScienceViewState extends State<FilterDataScienceView> {
  late FilterDataSciencePresenter _presenter;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _presenter = FilterDataSciencePresenter(
      model: FilterDataScienceModel(),
      countUpdate: (count) {
      setState(() {
        _count = count;
      });
    }),
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Count:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_count',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _presenter.decrementCounter,
                  child: Text('-'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _presenter.incrementCounter,
                  child: Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}