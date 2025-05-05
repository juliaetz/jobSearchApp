import 'package:flutter/material.dart';
import '../../PRESENTER/load_data.dart';
import '../../MODEL/data_read.dart';
import 'filter_jobs_in_data_view.dart';
import '../../PRESENTER/dataScienceJobs_presenter.dart';
class DataScienceListView extends StatefulWidget {
  @override
  _DataScienceListViewState createState() => _DataScienceListViewState();
}


class _DataScienceListViewState extends State<DataScienceListView> {
  final repo = DataJobRepository();
  List<DataJob> jobs = [];
  Map<int, bool> _isFavorited = <int,bool>{};

  handleFavorite(int? index, List<String>? data, String? dataType){

  }

  late DataJobsPresenter presenter;

  @override
  void initState() {
    super.initState();
    // Smoke test: load & print the top 5 entries
    repo.loadAndSort().then((list) {
      setState(() => jobs = list);
      for (var j in jobs.take(5)) {
        print('${j.jobTitle} @ ${j.companyLocation}: \$${j.salaryInUsd}');
      }
    });

    presenter = DataJobsPresenter();
    initData();
  }

  void initData() async {
    _isFavorited = await presenter.setMaps();
  }

    @override
    Widget build(BuildContext context) {
      return FutureBuilder<List<DataJob>>(
        future: repo.loadAndSort(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final jobs = snapshot.data!;
          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (_, i) {
              final j = jobs[i];
              return ListTile(
                title: Text('${j.jobTitle} • \$${j.salaryInUsd}'),
                subtitle: Text('${j.companyLocation} • ${j.experienceLevel}'),
                //trailing: Text('\$${j.salaryInUsd}'),
                trailing: IconButton(
                  onPressed: (){
                    updateData() async{
                      _isFavorited = await presenter.updateFavoriteData(i, jobs[i]);
                    }

                    setState(() {
                      updateData();
                    });
                  },
                  icon: Icon((_isFavorited[i] == true ? Icons.favorite : Icons
                      .favorite_border), color: Colors.green.shade700, size: 30.0,),
                ),

              );
            },
          );
        },
      );
    }
  }


class DataScienceJobsPage extends StatefulWidget {
  @override
  _DataScienceJobsPageState createState() => _DataScienceJobsPageState();
}


class _DataScienceJobsPageState extends State<DataScienceJobsPage> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    DataScienceListView(),
    FilterJobsInDataView(),
    Text("SearchJobsInDataViewHere"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: Text("Data Science Careers")),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
