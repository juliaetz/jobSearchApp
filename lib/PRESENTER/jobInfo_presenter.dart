import 'dart:math';

import 'package:flutter/material.dart';
import 'package:final_project/MODEL/jobInfo_model.dart';
import 'package:final_project/VIEW/jobInfo_view.dart';

class JobInfoPresenter {
  void updatePage(int index){}
  set jobInfoView(JobInfoView value){}
}

class BasicJobInfoPresenter extends JobInfoPresenter{
  late JobInfoModel _viewModel;
  late JobInfoView _view;

  BasicJobInfoPresenter() {
    this._viewModel = JobInfoModel();
    _viewModel.pageIndex = 0;
  }


  @override
  set jobInfoView(JobInfoView value) {
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
      page = _view.FavoriteJobsPage();
    } else {
      page = _view.FavoriteJobsPage();
    }

    _view.updatePage(page);
  }

}

