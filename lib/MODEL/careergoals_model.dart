import 'package:cloud_firestore/cloud_firestore.dart';
enum GoalType{shortTerm, longTerm}

class CareerGoal{
  final String id;
  final String goal;
  final GoalType goalType;
  final DateTime? creationDate;
  final bool isCompleted;
  final DateTime? completionDate;


  CareerGoal({
    required this.id,
    required this.goal,
    required this.goalType,
    this.creationDate,
    this.isCompleted = false,
    this.completionDate,


  });

  Map<String, dynamic> toMap() {
    return {
      'goal': goal,
      'goalType': goalType.name,
      'creationDate': creationDate != null ? Timestamp.fromDate(creationDate!) : null,
      'isCompleted': isCompleted,
      'completionDate': completionDate != null ? Timestamp.fromDate(completionDate!) : null,
    };

  }

  factory CareerGoal.fromMap(Map<String, dynamic> map, String id) {
      if(!map.containsKey('goal') ||
          !map.containsKey('goalType') ||
          !map.containsKey('isCompleted')){
        throw Exception('Invalid career goal data');
      }

      return CareerGoal(
        id: id,
        goal: map['goal'] ?? '',
        goalType: GoalType.values.firstWhere((type) => type.name == map['goalType']),
        creationDate: map['creationDate'] != null ? (map['creationDate'] as Timestamp).toDate() : null,
        isCompleted: map['isCompleted'],
        completionDate: map['completionDate'] != null ? (map['completionDate'] as Timestamp).toDate() : null,
      );
  }

}

