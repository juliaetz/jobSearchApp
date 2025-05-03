import 'package:cloud_firestore/cloud_firestore.dart';

enum GoalType{shortTerm, longTerm}

class CareerGoal{
  final String id;
  final String goal;
  final GoalType goalType;
  final DateTime completionDate;
  final bool isCompleted;
  final DateTime? createdAt;


  CareerGoal({
    required this.id,
    required this.goal,
    required this.goalType,
    required this.completionDate,
    this.isCompleted = false,
    this.createdAt,
  });




}

