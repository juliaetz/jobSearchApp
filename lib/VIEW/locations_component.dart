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
  List<int> _jobsSoftware = [38,35,28,28,20,20,18,12,12,12];
  List<int> _jobsData = [8132,449,226,113,71,50,24,24,21,17];
  Map<int,bool> _favoritedData = <int,bool>{};
  Map<int,bool> _favoritedSoftware = <int,bool>{};
  Map<String,String> _favorites = <String,String>{};

  handlePageChange(int? index) {
    this.widget.presenter.updatePage(index!);
  }

  handleFavorite(int? index, List<String>? data, String? dataType){
    this.widget.presenter.updateFavorite(index!, data!, dataType!);
  }

  handleRemoveFavorite(String? loc, String? dataType){
    this.widget.presenter.removeFavorite(loc!, dataType!);
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
  void updateFavorites(Map<String,String> map){
    setState(() {
      _favorites = map;
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
                    children: createRows(_topDataLocations, _favoritedData, "Data Science", _jobsData),
                 ),
                ),
              ),
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: createRows(_topSoftwareLocations, _favoritedSoftware, "Software Engineering", _jobsSoftware),//createSoftwareRows(),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }


  List<Widget> createRows(List<String> locations, Map<int,bool> isFavorited, String dataType, List<int> jobs) {
    return List.generate(locations.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Tooltip(
              message: 'There are ${jobs[index]} available $dataType jobs in ${locations[index]}',
              child: Text(locations[index], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             IconButton(
               onPressed: (){
                 handleFavorite(index, locations, dataType);
                 handlePageChange(_selectedIndex);
                 },
               icon: Icon((isFavorited[index] == true ? Icons.favorite : Icons.favorite_border), color: Colors.deepPurple.shade700, size: 30.0,),
             ),
            ],
          ),
        ],
      );
    });
  }




  @override
  Container FavoriteLocationsPage(){
    return Container(
      child: createFavorites()
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
            child: Column(
              children: [
                Text(entry.key, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                Text(entry.value, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  handleRemoveFavorite(entry.key, entry.value);
                  setState(() {
                    handlePageChange(_selectedIndex);
                  });
                },
                icon: Icon(Icons.delete, color: Colors.deepPurple.shade700, size: 30.0,),
              ),
            ],
          ),
        ],
      );
    }) .toList();
  }


}