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

  Widget _page = Placeholder();
  List<String> _favorites = ["temp", "temp2"];

  void handlePageChange(int index){
    this.widget.presenter.updatePage(index);
  }


  @override
  void updatePage(Widget page){
    setState(() {
      _page = page;
    });
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Job Information"),
          ],
        )
      ),

      body: _page,//_page,

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
    return List.generate(_favorites.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Text(_favorites[index], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
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
                  //handleRemoveFavorite(_favorites[index]);
                },
                icon: Icon(Icons.delete, color: Colors.green.shade700, size: 30.0,),
              ),
            ],
          ),
        ],
      );
    });
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

  /*@override
  Container FavoriteJobsPage(){
    return Container(

      child: Container(
        child: Column(
          children: [
            createFavorites(),
            Column(
              children: [
                createFindResources(),
                createFindLocations(),
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
    return List.generate(_favorites.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Text(_favorites[index], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
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
                    handleScheduledIdea(_favorites[index], scheduledDate, scheduledTime);
                  }
                },
                icon: Icon(Icons.calendar_month, color: Colors.deepPurple.shade700, size: 30.0,),
              ),
              IconButton(
                onPressed: (){
                  handleRemoveFavorite(_favorites[index]);
                },
                icon: Icon(Icons.delete, color: Colors.deepPurple.shade700, size: 30.0,),
              ),
            ],
          ),
        ],
      );
    });
  }

  Column createFindResources() {
    return Column(
      children: [
        Text('Need Help Preparing For Your Interview?'),
        ElevatedButton(
            onPressed: () {

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

            },
            child: Text('Find The Best Locations'))
      ],
    );
  }*/