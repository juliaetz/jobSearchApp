import 'package:flutter/material.dart';
import 'package:final_project/MODEL/resources_model.dart';
import 'package:final_project/VIEW/resources_view.dart';

class ResourcesPresenter {
  void updatePage(int index){}
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

    updatePage(_viewModel.pageIndex);
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

    _view.updatePage(page);
  }

}