import 'package:final_project/MODEL/data_read.dart';
import 'package:flutter/material.dart';
import 'package:final_project/VIEW/jobHomePage.dart';
import 'package:final_project/PRESENTER/jobInfo_presenter.dart';
import 'jobInfo_view.dart';
import 'package:final_project/PRESENTER/resources_presenter.dart';
import 'package:final_project/VIEW/resources_component.dart';
import 'package:final_project/PRESENTER/locations_presenter.dart';
import 'package:final_project/VIEW/locations_component.dart';


class JobInfoPage extends StatefulWidget {
  final JobInfoPresenter presenter;

  JobInfoPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _JobInfoPageState createState() => _JobInfoPageState();
}



class _JobInfoPageState extends State<JobInfoPage> implements JobInfoView {
  @override
  void initState() {
    super.initState();
    this.widget.presenter.jobInfoView = this;
  }

  Widget _page = JobHomePage();
  Map<String,favoriteJob> _favorites = <String,favoriteJob>{};
  bool _isLoading = true;

  void handlePageChange(){
    this.widget.presenter.updatePage();
  }

  void handleRemoveFavorite(String? key, String? dataType){
   this.widget.presenter.removeFavorite(key!, dataType!);
  }

  @override
  void updatePage(Widget page){
    setState(() {
      _page = page;
      _isLoading = false;
    });
  }

  @override
  void updateFavorites(Map<String,favoriteJob> map){
    setState(() {
      _favorites = map;
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _isLoading ? null : AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Job Information"),
          ],
        )
      ),

      body: _page,

    );
  }

  @override
  Container FavoriteJobsPage(){
    return Container(

      child: Container(
        child: Column(
          children: [
            Text('Favorite Jobs', textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            createFavorites(),
            Column(
              children: [
                createFindResources(),
                SizedBox(height: 15,),
                createFindLocations(),
                SizedBox(height: 20,),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded createFavorites() {
    return Expanded(
      flex: 9,
      child: SingleChildScrollView(
        child: Column(
          children: createFavoritesRows(),
        ),
      ),
    );
  }

  List<Widget> createFavoritesRows() {
    return _favorites.entries.map ((entry) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: ListTile(
              title: Text("${entry.value.jobTitle} • \$${entry.value.salary}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              subtitle: Text("${entry.value.location} • ${entry.value.companyOrEmploymentType}"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  TimeOfDay? scheduledTime;
                  DateTime? scheduledDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2025),
                    lastDate: DateTime(2100),
                  );
                  if(scheduledDate != null) {
                    scheduledTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  }
                  if(scheduledTime != null){
                    //handleScheduledIdea(_favorites[index], scheduledDate, scheduledTime);
                  }
                },
                icon: Icon(Icons.calendar_month, color: Colors.green.shade700, size: 30.0,),
              ),
              IconButton(
                onPressed: (){
                  handleRemoveFavorite(entry.key, entry.value.dataType);
                  setState(() {
                    handlePageChange();
                  });
                },
                icon: Icon(Icons.delete, color: Colors.green.shade700, size: 30.0,),
              ),
            ],
          ),
        ],
      );
    }) .toList();
  }

  Column createFindResources() {
    return Column(
      children: [
        Text('Need Help Preparing For Your Interview?'),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResourcesPage(BasicResourcesPresenter(),
                        title: 'RESOURCES', key: const Key('RESOURCES'))),
              );
            },
            child: Text('Interview Resources'))
      ],
    );
  }

  Column createFindLocations() {
    return Column(
      children: [
        Text('Continue Your Job Search?'),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationsPage(BasicLocationsPresenter(),
                        title: 'LOCATIONS', key: const Key('LOCATIONS'))),
              );
            },
            child: Text('Find The Best Locations'))
      ],
    );
  }

}