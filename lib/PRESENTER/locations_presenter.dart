import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../MODEL/locations_model.dart';
import '../VIEW/locations_view.dart';

class LocationsPresenter {
  void updatePage(int index){}
  void updateFavorite(int index, List<String> data, String dataType){}
  void removeFavorite(String location, String dataType){}
  set locationsView(LocationsView value){}
}

class BasicLocationsPresenter extends LocationsPresenter{
  late LocationsModel _viewModel;
  late LocationsView _view;

  BasicLocationsPresenter() {
    this._viewModel = LocationsModel();
    _viewModel.pageIndex = 0;
  }


  @override
  set locationsView(LocationsView value) {
    _view = value;

    initialize();
  }

  void initialize() async {
    await setMaps();
    updatePage(_viewModel.pageIndex);
  }

  Future<void> setMaps() async {
    CollectionReference locationsDatabaseRef = await _viewModel.getLocationsDatabaseReference();
    await locationsDatabaseRef.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        if(docs.get("Job") == "Software Engineering"){
          _viewModel.softwareFavorited[docs.get("Index")] = true;
        } else {
          _viewModel.dataFavorited[docs.get("Index")] = true;
        }
        _viewModel.favoritesList[docs.get("Location")] = docs.get("Job");
      }
    });

    _view.updateFavorites(_viewModel.favoritesList);
    _view.updateMap("Software Engineering", _viewModel.softwareFavorited);
    _view.updateMap("Data Science", _viewModel.dataFavorited);
  }

  @override
  void updatePage(int index){
    if(index != _viewModel.pageIndex){
      _viewModel.pageIndex = index;
    }

    Widget page;
    if(_viewModel.pageIndex == 0){
      page = _view.LocationsPage();
    } else {
      page = _view.FavoriteLocationsPage();
    }

    _view.updateSelectedIndex(_viewModel.pageIndex);
    _view.updatePage(page);
  }



  @override
  void updateFavorite(int index, List<String> data, String dataType) async {
    Map<int,bool> favorited = chooseMap(dataType);
    updateBool(favorited, index);
    CollectionReference locationsDatabaseRef = await _viewModel.getLocationsDatabaseReference();

    if(favorited[index] == true){
        locationsDatabaseRef.doc().set(
          {
            "Location": data[index],
            "Job": dataType,
            "Index": index,
          });
        _viewModel.favoritesList[data[index]] = dataType;
      } else {
        DocumentSnapshot? currDoc;
        await locationsDatabaseRef.get().then((results){
          for(DocumentSnapshot docs in results.docs){
            if(docs.get("Location") == data[index]){
              currDoc = docs;
            }
          }
        });
        String? id = currDoc?.id;
        locationsDatabaseRef.doc(id).delete();
        _viewModel.favoritesList.remove(data[index]);
      }

    _view.updateFavorites(_viewModel.favoritesList);
    _view.updateMap(dataType, favorited);
  }

  Map<int,bool> chooseMap (String dataType){
    if(dataType == "Software Engineering"){
      return _viewModel.softwareFavorited;
    } else {
      return _viewModel.dataFavorited;
    }
  }

  void updateBool(Map<int,bool> map, int index){
    if(map[index] == null){
      map[index] = true;
    } else {
      bool? curr = map[index];
      map [index] = !curr!;
    }
  }

  @override
  void removeFavorite(String location, String dataType) async {
    _viewModel.favoritesList.remove(location); // done right away to avoid issues
    CollectionReference locationsDatabaseRef = await _viewModel.getLocationsDatabaseReference();

    DocumentSnapshot? currDoc;
    await locationsDatabaseRef.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        if(docs.get("Location") == location){
          currDoc = docs;
        }
      }
    });
    String? id = currDoc?.id;
    int? index = currDoc?.get("Index");

    locationsDatabaseRef.doc(id).delete();

    Map<int,bool> favorited = chooseMap(dataType);
    updateBool(favorited, index!);


    _view.updateFavorites(_viewModel.favoritesList);
  }



}