import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_project/MODEL/jobInfo_model.dart';
import 'package:final_project/VIEW/jobInfo_view.dart';

import '../MODEL/data_read.dart';

class JobInfoPresenter {
  void updatePage(){}
  void removeFavorite(String key, String dataType){}
  void scheduleInterview(String job, DateTime date, TimeOfDay time){}
  set jobInfoView(JobInfoView value){}
}

class BasicJobInfoPresenter extends JobInfoPresenter{
  late JobInfoModel _viewModel;
  late JobInfoView _view;

  BasicJobInfoPresenter() {
    this._viewModel = JobInfoModel();
  }


  @override
  set jobInfoView(JobInfoView value) {
    _view = value;

    initialize();
  }

  void initialize() async {
    await setMaps();
    updatePage();
  }

  @override
  void updatePage(){
    _view.updatePage(_view.FavoriteJobsPage());
  }

  Future<void> setMaps() async {
    await _viewModel.jobsDatabaseReference.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        String CoET = "";
        if(docs.get("Job_Type") == "Software Engineering"){
          CoET = docs.get("Company");
        } else {
          CoET = docs.get("Employment_Type");
        }
        String job = docs.get("Job_Title");
        String location = docs.get("Location");
        String salary = docs.get("Salary").toString();
        String type = docs.get("Job_Type");
        String index = docs.get("Index").toString();

        favoriteJob fave = favoriteJob(job, location, salary, CoET, type);
        String key = "$type.$index";

        _viewModel.favoritesList[key] = fave;
      }
    });

    _view.updateFavorites(_viewModel.favoritesList);
  }

  @override
  void removeFavorite(String key, String dataType) async {
    _viewModel.favoritesList.remove(key); // done right away to avoid issues

    DocumentSnapshot? currDoc;
    await _viewModel.jobsDatabaseReference.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        String jobInfo = "${docs.get("Job_Type")}.${docs.get("Index").toString()}";
        if(key == jobInfo){
          currDoc = docs;
        }
      }
    });
    String? id = currDoc?.id;

    _viewModel.jobsDatabaseReference.doc(id).delete();

    _view.updateFavorites(_viewModel.favoritesList);
  }

  @override
  void scheduleInterview(String job, DateTime date, TimeOfDay time){
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    String interview = "$job Interview";
    _viewModel.interviewsDatabaseReference.doc().set(
      {
        "title": interview,
        "dateTime": dateTime,
      }
    );
  }

}

