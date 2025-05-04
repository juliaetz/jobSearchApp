import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:final_project/PRESENTER/resources_presenter.dart';
import '../PRESENTER/jobInfo_presenter.dart';
import 'jobInfo_component.dart';
import 'resources_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:final_project/MODEL/articleInfo.dart';

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


  late InAppWebViewController inAppWebViewController;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();

  Widget _page = JobInfoPage(BasicJobInfoPresenter(), title: '', key: const Key(''));
  int _selectedIndex = 0;
  bool _isLoading = true;
  List<articleInfo> resources = [articleInfo("https://www.indeed.com/career-advice/interviewing/how-to-prepare-for-an-interview", "How to Prepare for an Interview", "Indeed", "assets/images/indeedResource.jpg"),
  articleInfo("https://joinhandshake.com/blog/students/how-to-prepare-for-an-interview/", "How to prepare for an interview (steps & tips)", "Handshake", "assets/images/handshakeResource.jpg"),
  articleInfo("https://www.freecodecamp.org/news/problem-solving-and-technical-interview-prep/", "How to Prepare for Technical Interviews – Problem-Solving Tips + Mindset Tricks to Get You Ready", "Free Code Camp", "assets/images/freeCodeCampResource.jpg"),
  articleInfo("https://www.techinterviewhandbook.org/coding-interview-prep/", "Coding interviews: Everything you need to prepare", "Tech Interview Handbook", "assets/images/tirResource.jpg"),
  articleInfo("https://www.lambrospetrou.com/articles/big-tech-software-interviews/", "How to pass the interview for software engineering roles in Big Tech", "Lambros Petrou", "assets/images/lambrosResource.jpg"), 
  articleInfo("https://www.springboard.com/blog/software-engineering/21-software-engineering-interview-questions/", "20 Software Engineering Interview Questions (+ Answers)", "Springboard", "assets/images/springboardResource.jpeg"),
  articleInfo("https://www.techinterviewhandbook.org/software-engineering-interview-guide/", "Software Engineer interviews: Everything you need to prepare", "Tech Interview Handbook", "assets/images/tihSResource.png"),
  articleInfo("https://www.career.msstate.edu/blog/2024/07/02/20-common-data-science-interview-questions/", "20 Common Data Science Interview Questions", "MS State Career Center", "assets/images/missResource.png"),
  articleInfo("https://www.datacamp.com/blog/data-science-interview-preparation", "Data Science Interview Preparation", "Datacamp", "assets/images/datacampResource.jpg"),
  articleInfo("https://github.com/rbhatia46/Data-Science-Interview-Resources", "Data Science Interview Resources", "Github", "assets/images/gitResource.png"),
  ];
  Map<String, articleInfo> _favorites = <String,articleInfo>{};
  Map<int,bool> _isFavorited = <int,bool>{};


  handlePageChange(index) {
    this.widget.presenter.updatePage(index);
  }

  handleFavorite(int? index, articleInfo data){
    this.widget.presenter.updateFavorite(index!, data);
  }

  handleRemoveFavorite(String? URL){
    this.widget.presenter.removeFavorite(URL!);
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
  void updateMap(Map<int,bool> map){
    setState(() {
      _isFavorited = map;
    });
  }

  @override
  void updateFavorites(Map<String,articleInfo> favorites){
    setState(() {
      _favorites = favorites;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLoading ? null : AppBar(
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Interview Resources"),
            ],
          )
      ),

      body: _page, //_page,


      bottomNavigationBar: _isLoading ? null: BottomNavigationBar(
        backgroundColor: Colors.green,
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
      child: Expanded(
        flex: 9,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text("Resources to Help You Prepare For Your Interview", style: TextStyle(fontSize: 25)),
                      ),
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
            ),
        ),
      ),
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
                      SizedBox(height: 10.0,),
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
                  onPressed: () {
                    handleFavorite(index, resources[index]);
                    handlePageChange(_selectedIndex);
                  },
                  icon: Icon(
                    (_isFavorited[index] == true ? Icons.favorite : Icons
                        .favorite_border), color: Colors.green.shade700,
                    size: 30.0,),
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
      child: Expanded(
        flex: 9,
        child: SingleChildScrollView(
          child: createRows(),
        ),
      ),
    );
  }

  Expanded createRows(){
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
    return _favorites.entries.map ((entry){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          SizedBox(height: 10.0,),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Row(
              children: [
                InkWell(
                  child: Image.asset(entry.value.imageAsset, width: 100,),
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return InAppWebView(
                            key: _key,
                            gestureRecognizers: gestureRecognizers,
                            initialUrlRequest: URLRequest(
                              url: WebUri.uri(Uri.parse(entry.value.URL)),
                            ),
                            onWebViewCreated: (InAppWebViewController controller){
                              inAppWebViewController = controller;
                            }
                        );
                      }
                  ),
                ),
                SizedBox(width: 20,),
                Flexible(
                  child: Column(
                    children: [
                      Text(entry.value.articleTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      Text(entry.value.website, style: TextStyle(fontSize: 15,),),
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
                onPressed: () {
                  handleRemoveFavorite(entry.key);
                  setState(() {
                    handlePageChange(_selectedIndex);
                  });
                },
                icon: Icon(Icons.delete, color: Colors.green,
                  size: 30.0,),
              ),
            ],
          ),
        ],
      );
    }) .toList();
  }


}