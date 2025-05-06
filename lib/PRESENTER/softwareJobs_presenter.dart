import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_project/MODEL/softwareJobs_model.dart';
import 'package:final_project/VIEW/jobInfo_view.dart';
import 'package:final_project/VIEW/SOFTWARE_ENG/softwareEngJobsPage.dart';

import '../MODEL/data_read.dart';

import '../model/filter_jobs_in_data_model.dart';

class SoftwareJobsPresenter{
  late SoftwareJobsModel _viewModel;
  SoftwareJobsPresenter(){
    this._viewModel = SoftwareJobsModel();
  }

  Future<Map<int,bool>> setMaps() async {
    CollectionReference jobsDatabaseRef = await _viewModel.getJobsDatabaseReference();
    await jobsDatabaseRef.get().then((results){
      for(DocumentSnapshot docs in results.docs){
        if(docs["Job_Type"] == "Software Engineering") {
          _viewModel.favoritedData[docs.get("Index")] = true;
        }
      }
    });

    return _viewModel.favoritedData;
  }



  Future<Map<int, bool>> updateFavoriteData(int index, Job data) async {
    updateBool(index);
    CollectionReference jobsDatabaseRef = await _viewModel.getJobsDatabaseReference();
    if(_viewModel.favoritedData[index] == true){
      jobsDatabaseRef.doc().set(
          {
            "Location": data.location,
            "Job_Title": data.title,
            "Company": data.company,
            "Salary": data.avgSalary,
            "Index": index,
            "Job_Type": "Software Engineering",
          });
    } else {
      DocumentSnapshot? currDoc;
      await jobsDatabaseRef.get().then((results){
        for(DocumentSnapshot docs in results.docs){
          if(docs.get("Index") == index && docs.get("Job_Type") == "Software Engineering"){
            currDoc = docs;
          }
        }
      });
      String? id = currDoc?.id;
      jobsDatabaseRef.doc(id).delete();

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