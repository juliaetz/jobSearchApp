import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../MODEL/resources_model.dart';
import '../VIEW/resources_view.dart';

import '../MODEL/articleInfo.dart';

class ResourcesPresenter {
  void updatePage(int index){}
  void updateFavorite(int index, articleInfo data){}
  void removeFavorite(String URL){}
  set resourcesView(ResourcesView value){}
}



class BasicResourcesPresenter extends ResourcesPresenter{
  late ResourcesModel _viewModel;
  late ResourcesView _view;

  BasicResourcesPresenter() {
    this._viewModel = ResourcesModel();
    _viewModel.pageIndex = 0;
  }


  @override
  set resourcesView(ResourcesView value) {
    _view = value;

    initialize();
  }

  void initialize() async {
    await setMaps();
    updatePage(_viewModel.pageIndex);
  }

  Future<void> setMaps() async {
    CollectionReference resourcesDatabaseRef = await _viewModel.getResourcesDatabaseReference();
    await resourcesDatabaseRef.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        _viewModel.favorited[docs.get("Index")] = true;
        String url = docs.get("URL");
        String title = docs.get("Title");
        String web = docs.get("Website");
        String image = docs.get("Image");

        articleInfo article = articleInfo(url, title, web, image);

        _viewModel.favoritesList[docs.get("URL")] = article;
      }
    });

    _view.updateFavorites(_viewModel.favoritesList);
    _view.updateMap(_viewModel.favorited);
  }


  @override
  void updatePage(int index){
    if(index != _viewModel.pageIndex){
      _viewModel.pageIndex = index;
    }

    Widget page;
    if(_viewModel.pageIndex == 0){
      page = _view.ResourcePage();
    } else {
      page = _view.FavoriteResourcesPage();
    }

    _view.updateSelectedIndex(_viewModel.pageIndex);
    _view.updatePage(page);
  }


  @override
  void updateFavorite(int index, articleInfo data) async {
    updateBool(index);
    CollectionReference resourcesDatabaseRef = await _viewModel.getResourcesDatabaseReference();

    if(_viewModel.favorited[index] == true){
      resourcesDatabaseRef.doc().set(
          {
            "URL": data.URL,
            "Title": data.articleTitle,
            "Website": data.website,
            "Image": data.imageAsset,
            "Index": index,
          });
      _viewModel.favoritesList[data.URL] = data;
    } else {
      DocumentSnapshot? currDoc;
      await resourcesDatabaseRef.get().then((results){
        for(DocumentSnapshot docs in results.docs){
          if(docs.get("URL") == data.URL){
            currDoc = docs;
          }
        }
      });
      String? id = currDoc?.id;
      resourcesDatabaseRef.doc(id).delete();
      _viewModel.favoritesList.remove(data.URL);
    }

    _view.updateFavorites(_viewModel.favoritesList);
    _view.updateMap(_viewModel.favorited);
  }


  void updateBool(int index){
    if(_viewModel.favorited[index] == null){
      _viewModel.favorited[index] = true;
    } else {
      bool? curr = _viewModel.favorited[index];
      _viewModel.favorited [index] = !curr!;
    }
  }

  @override
  void removeFavorite(String URL) async {
    _viewModel.favoritesList.remove(URL); // done right away to avoid issues
    CollectionReference resourcesDatabaseRef = await _viewModel.getResourcesDatabaseReference();

    DocumentSnapshot? currDoc;
    await resourcesDatabaseRef.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        if(docs.get("URL") == URL){
          currDoc = docs;
        }
      }
    });
    String? id = currDoc?.id;
    int? index = currDoc?.get("Index");

    resourcesDatabaseRef.doc(id).delete();

    updateBool(index!);


    _view.updateFavorites(_viewModel.favoritesList);
  }


}