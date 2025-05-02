import 'package:flutter/material.dart';
import 'package:final_project/MODEL/locations_model.dart';
import 'package:final_project/VIEW/locations_view.dart';

class LocationsPresenter {
  void updatePage(int index){}
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

    updatePage(_viewModel.pageIndex);
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

    _view.updatePage(page);
  }

}