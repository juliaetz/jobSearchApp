import 'package:final_project/PRESENTER/jobInfo_presenter.dart';
import 'package:flutter/material.dart';
import 'package:final_project/VIEW/jobInfo_component.dart';
import 'package:final_project/PRESENTER/locations_presenter.dart';
import 'locations_view.dart';

class LocationsPage extends StatefulWidget {
  final LocationsPresenter presenter;

  LocationsPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LocationsPageState createState() => _LocationsPageState();
}



class _LocationsPageState extends State<LocationsPage> implements LocationsView {
  @override
  void initState() {
    super.initState();
    this.widget.presenter.locationsView = this;
  }

  bool _isLoading = true;
  Widget _page = JobInfoPage(BasicJobInfoPresenter(), title: '', key: const Key(''));
  int _selectedIndex = 0;
  List<String> _topDataLocations = ["USA", "UK", "Canada", "Spain", "Germany", "France", "Australia", "Portugal", "Netherlands", "Brazil"];
  List<String> _topSoftwareLocations = ["Remote", "Annapolis Junction", "Seattle", "San Francisco", "Boston", "San Jose", "New York", "Chicago", "Bellevue", "Atlanta"];
  Map<int,bool> _favoritedData = <int,bool>{};
  Map<int,bool> _favoritedSoftware = <int,bool>{};

  handlePageChange(int? index) {
    this.widget.presenter.updatePage(index!);
  }

  handleFavorite(int? index, List<String>? data, String? dataType){
    this.widget.presenter.updateFavorite(index!, data!, dataType!);
  }

  @override
  void updatePage(Widget page){
    setState(() {
      _page = page;
      _isLoading = false;
    });
  }

  @override
  void updateSelectedIndex(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void updateMap(String dataType, Map<int,bool> map){
    setState(() {
      if(dataType == "Software Engineering"){
        _favoritedSoftware = map;
      } else {
        _favoritedData = map;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading ? null : AppBar(
          backgroundColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Best Work Locations"),
            ],
          )
      ),

      body: _page, //_page,

      bottomNavigationBar: _isLoading ? null : BottomNavigationBar(
        backgroundColor: Colors.grey.shade800,
        iconSize: 30.0,

        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedFontSize: 23.0,
        selectedItemColor: Colors.white,

        unselectedIconTheme: IconThemeData(color: Colors.grey),
        unselectedFontSize: 18.0,
        unselectedItemColor: Colors.white,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            handlePageChange(index);
          });
        },
      ),
    );
  }

  @override
  Container LocationsPage(){
    return Container(
      //child: Text('This will be the locations page'),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("For Data Jobs"),
              SizedBox(width: 50.0,),
              Text("For Software Jobs"),
            ]
          ),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: createRows(_topDataLocations, _favoritedData, "Data Science"),
                 ),
                ),
              ),
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: createRows(_topSoftwareLocations, _favoritedSoftware, "Software Engineering"),//createSoftwareRows(),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }


  List<Widget> createRows(List<String> locations, Map<int,bool> isFavorited, String dataType) {
    return List.generate(locations.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Text(locations[index],
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  handleFavorite(index, locations, dataType);
                  /*setState(() {
                    print("On the other side value for index $index is ${isFavorited[index]}");
                    if(isFavorited[index] == true){
                      heart = Icons.favorite;
                    }
                  });*/
                  handlePageChange(_selectedIndex);
                },
                icon: Icon((isFavorited[index] == true ? Icons.favorite : Icons.favorite_border), color: Colors.deepPurple.shade700, size: 30.0,),
              )
            ],
          ),
        ],
      );
    });
  }




  @override
  Container FavoriteLocationsPage(){
    return Container(
      child: Text('This is the favorite locations page'),
    );
  }


}