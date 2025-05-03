import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:final_project/PRESENTER/resources_presenter.dart';
import 'resources_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class ResourcesPage extends StatefulWidget {
  final ResourcesPresenter presenter;

  ResourcesPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class articleInfo{
  String URL = "example.com";
  String articleTitle = "";
  String website = "";
  String imageAsset = "";

  articleInfo(String url, String title, String web, String image){
    URL = url;
    articleTitle = title;
    website = web;
    imageAsset = image;
  }
}



class _ResourcesPageState extends State<ResourcesPage> implements ResourcesView {
  @override
  void initState() {
    super.initState();
    this.widget.presenter.resourcesView = this;
  }

  final DraggableScrollableController sheetController = DraggableScrollableController();
  late InAppWebViewController inAppWebViewController;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();

  Widget _page = Placeholder();
  int _selectedIndex = 0;
  bool _isLoading = true;
  List<articleInfo> resources = [articleInfo("https://www.indeed.com/career-advice/interviewing/how-to-prepare-for-an-interview", "How to Prepare for an Interview", "Indeed", "assets/images/indeedResource.jpg"),];
  Map<int,bool> _isFavorited = <int,bool>{};

  handlePageChange(index) {
    this.widget.presenter.updatePage(index);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Interview Resources"),
            ],
          )
      ),

      body: _page, //_page,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple.shade700,
        iconSize: 30.0,

        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedFontSize: 23.0,
        selectedItemColor: Colors.white,

        unselectedIconTheme: IconThemeData(color: Colors.deepPurple.shade200),
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
    //child: Text('This will be the locations page'),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Resources to Help You Prepare For Your Interview"),
              SizedBox(height: 10.0,),
            ]
          ),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: createArticleRows(),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }


  List<Widget> createArticleRows() {
    return List.generate(resources.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Row(
              children: [
                InkWell(
                  child: Image.asset(resources[index].imageAsset, width: 100,),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return InAppWebView(
                        key: _key,
                        gestureRecognizers: gestureRecognizers,
                        initialUrlRequest: URLRequest(
                        url: WebUri.uri(Uri.parse(resources[index].URL)),
                        ),
                        onWebViewCreated: (InAppWebViewController controller){
                          inAppWebViewController = controller;
                        }
                      );
                    }
                  ),
                ),
                SizedBox(width: 10,),
                Flexible(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Text(resources[index].articleTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      Text(resources[index].website, style: TextStyle(fontSize: 15,),),
                  ],
                ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  //handleFavorite(index, locations, dataType);
                  //handlePageChange(_selectedIndex);
                },
                icon: Icon((_isFavorited[index] == true ? Icons.favorite : Icons.favorite_border), color: Colors.deepPurple.shade700, size: 30.0,),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  Container FavoriteResourcesPage(){
    return Container(
      child: Text('This will be the favorite resources page'),
    );
  }
}