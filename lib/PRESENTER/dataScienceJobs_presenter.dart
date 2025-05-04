import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_project/MODEL/dataScienceJobs_model.dart';
import 'package:final_project/VIEW/jobInfo_view.dart';
import 'package:final_project/VIEW/DATA_SCIENCE/dataScienceJobsPage.dart';

import '../MODEL/data_read.dart';

import '../model/filter_jobs_in_data_model.dart';

class DataJobsPresenter{
  late DataJobsModel _viewModel;
  DataJobsPresenter(){
    this._viewModel = DataJobsModel();
  }

  Future<Map<int,bool>> setMaps() async {
    await _viewModel.jobsDatabaseReference.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        if(docs["Job_Type"] == "Data Science") {
          _viewModel.favoritedData[docs.get("Index")] = true;
        }
      }
    });

    return _viewModel.favoritedData;
  }



  Future<Map<int, bool>> updateFavoriteData(int index, DataJob data) async {
    updateBool(index);

    if(_viewModel.favoritedData[index] == true){
      _viewModel.jobsDatabaseReference.doc().set(
          {
            "Location": data.companyLocation,
            "Job_Title": data.jobTitle,
            "Employment_Type": data.employmentType,
            "Salary": data.salaryInUsd,
            "Index": index,
            "Job_Type": "Data Science",
          });
    } else {
      DocumentSnapshot? currDoc;
      await _viewModel.jobsDatabaseReference.get().then((results){
        for(DocumentSnapshot docs in results.docs){
          if(docs.get("Index") == index){
            currDoc = docs;
          }
        }
      });
      String? id = currDoc?.id;
      _viewModel.jobsDatabaseReference.doc(id).delete();

    }

    return _viewModel.favoritedData;
  }


  void updateBool(int index){
    if(_viewModel.favoritedData[index] == null){
      _viewModel.favoritedData[index] = true;
    } else {
      bool? curr = _viewModel.favoritedData[index];
      _viewModel.favoritedData[index] = !curr!;
    }
  }

}




/*class DataJobsPresenter {
  void updatePage(int index){}
  void updateFavoriteData(int index, DataJob data){}
  void removeFavorite(String URL){}
  set dataJobsView(DataScienceListViewState value){}
}

class BasicDataJobsPresenter extends DataJobsPresenter{
  late DataJobsModel _viewModel;
  late _DataScienceListViewState _view;

  BasicDataJobsPresenter() {
    this._viewModel = DataJobsModel();
    //_viewModel.pageIndex = 0;
  }


  @override
  set dataJobsView(_DataScienceListViewState value) {
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


  @override
  void updateFavoriteData(int index, Job data) async {
    updateBool(_viewModel.favoritedSoftware, index);

    if(_viewModel.favoritedSoftware[index] == true){
      _viewModel.jobsDatabaseReference.doc().set(
          {
            "Location": data.location,
            "Job": data.title,
            "Company": data.company,
            "Salary": data.avgSalary,
            "Index": index,
          });
      _viewModel.favoriteSoftwareList[index] = data;
    } else {
      DocumentSnapshot? currDoc;
      await _viewModel.jobsDatabaseReference.get().then((results){
        for(DocumentSnapshot docs in results.docs){
          if(docs.get("Index") == index){
            currDoc = docs;
          }
        }
      });
      String? id = currDoc?.id;
      _viewModel.jobsDatabaseReference.doc(id).delete();
      _viewModel.favoriteSoftwareList.remove(index);
    }

    _view.updateFavorites(_viewModel.favoritesList);
    _view.updateMap(_viewModel.favoritedSoftware);
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

    DocumentSnapshot? currDoc;
    await _viewModel.locationsDatabaseReference.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        if(docs.get("Location") == location){
          currDoc = docs;
        }
      }
    });
    String? id = currDoc?.id;
    int? index = currDoc?.get("Index");

    _viewModel.locationsDatabaseReference.doc(id).delete();

    Map<int,bool> favorited = chooseMap(dataType);
    updateBool(favorited, index!);


    _view.updateFavorites(_viewModel.favoritesList);
  }




}*/