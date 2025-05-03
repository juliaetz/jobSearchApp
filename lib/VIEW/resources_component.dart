import 'package:flutter/material.dart';
import 'package:final_project/PRESENTER/resources_presenter.dart';
import 'resources_view.dart';

class ResourcesPage extends StatefulWidget {
  final ResourcesPresenter presenter;

  ResourcesPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}



class _ResourcesPageState extends State<ResourcesPage> implements ResourcesView {
  @override
  void initState() {
    super.initState();
    this.widget.presenter.resourcesView = this;
  }

  Widget _page = Placeholder();
  int _selectedIndex = 0;

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
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Interview Resources"),
            ],
          )
      ),

      body: _page, //_page,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade900,
        iconSize: 30.0,

        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedFontSize: 23.0,
        selectedItemColor: Colors.white,

        unselectedIconTheme: IconThemeData(color: Colors.green.shade100),
        unselectedFontSize: 18.0,
        unselectedItemColor: Colors.white,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Resources',
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
  Container ResourcePage(){
    return Container(
      child: Text('This will be the resources page'),
    );
  }

  @override
  Container FavoriteResourcesPage(){
    return Container(
      child: Text('This will be the favorite resources page'),
    );
  }
}