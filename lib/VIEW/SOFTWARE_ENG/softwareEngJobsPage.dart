import 'package:final_project/VIEW/SOFTWARE_ENG/filter_jobs_in_software_view.dart';
import 'package:flutter/material.dart';
import '../../PRESENTER/load_data.dart';
import '../../MODEL/data_read.dart';
import 'software_job_search_tab.dart';
import '../../PRESENTER/softwareJobs_presenter.dart';


class SoftwareEngJobsPage extends StatefulWidget {
  @override
  _SoftwareEngJobsPageState createState() => _SoftwareEngJobsPageState();
}

class _SoftwareEngJobsPageState extends State<SoftwareEngJobsPage> {
  final repo = JobRepository();
  List<Job> jobs = [];
  String? loadError;
  int _selectedIndex = 0;
  Map<int, bool> _isFavorited = <int,bool>{};

  late SoftwareJobsPresenter presenter;

  @override
  void initState() {
    super.initState();

    presenter = SoftwareJobsPresenter();
    initData();

    repo.loadAndSort()
        .then((list) => setState(() => jobs = list))
        .catchError((e) => setState(() => loadError = e.toString()));
  }

  void initData() async {
    _isFavorited = await presenter.setMaps();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (loadError != null) {
      content = Center(child: Text('Error: $loadError'));
    } else if (jobs.isEmpty) {
      content = Center(child: CircularProgressIndicator());
    } else {
      // Define your tabs here:
      final tabs = <Widget>[
        // 1) List view
        ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (_, i) {
            final j = jobs[i];
            return ListTile(
              title: Text('${j.title} • \$${j.avgSalary}'),
              subtitle: Text('${j.company} • ${j.location}'),
              //trailing: Text('\$${j.avgSalary}'),
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
        ),
        // 2) Filter by location/company
        FilterJobsInSoftwareView(),
        // 3) Search
        SoftEngJobSearchTab(allJobs: jobs),
      ];
      content = tabs[_selectedIndex];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Software Engineering Careers'),
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
