import 'package:flutter/material.dart';
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

  Widget _page = Placeholder();
  int _selectedIndex = 0;
  List<String> _topDataLocations = ["USA", "UK", "Canada", "Spain", "Germany", "France", "Australia", "Portugal", "Netherlands", "Brazil"];
  List<String> _topSoftwareLocations = ["Remote", "Annapolis Junction", "Seattle", "San Francisco", "Boston", "San Jose", "New York", "Chicago", "Bellevue", "Atlanta"];
  List<bool> _isFavoritedData = [false, false, false, false, false, false, false, false, false, false];

  handlePageChange(index) {
    this.widget.presenter.updatePage(index);
  }

  @override
  void updatePage(Widget page){
    setState(() {
      _page = page;
    });
  }

  @override
  void updateSelectedIndex(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Best Work Locations"),
            ],
          )
      ),

      body: _page, //_page,

      bottomNavigationBar: BottomNavigationBar(
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
                    children: createDataRows(),
                 ),
                ),
              ),
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: createSoftwareRows(),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }

  List<Widget> createDataRows() {
    return List.generate(_topDataLocations.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Text(_topDataLocations[index],
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    _isFavoritedData[index] = !_isFavoritedData[index];
                  });
                  handlePageChange(_selectedIndex);
                },
                icon: Icon(
                  _isFavoritedData[index] ? Icons.favorite : Icons.favorite_border,
                  color: Colors.deepPurple.shade700, size: 30.0,),
              )
            ],
          ),
        ],
      );
    });
  }


  List<Widget> createSoftwareRows() {
    return List.generate(_topSoftwareLocations.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Text(_topSoftwareLocations[index],
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.favorite_border, color: Colors.deepPurple.shade700, size: 30.0,),
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