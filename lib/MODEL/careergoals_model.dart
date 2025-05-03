enum GoalType{shortTerm, longTerm}

class CareerGoal{
  final String id;
  final String goal;
  final GoalType goalType;
  final DateTime completionDate;
  final bool isCompleted;
  final DateTime? creationDate;


  CareerGoal({
    required this.id,
    required this.goal,
    required this.goalType,
    required this.completionDate,
    this.isCompleted = false,
    this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'goal': goal,
      'goalType': goalType.toString(),
      'completionDate': completionDate.toIso8601String(),
      'isCompleted': isCompleted,
      'createdAt': creationDate?.toIso8601String(),
    };

  }

  factory CareerGoal.fromMap(Map<String, dynamic> map, String id) {
      if(!map.containsKey('goal') || !map.containsKey('goalType')
          || !map.containsKey('completionDate') || !map.containsKey('isCompleted')
          || !map.containsKey('createdAt')){
        throw Exception('Invalid career goal data');
      }

      return CareerGoal(
        id: id,
        goal: map['goal'] ?? '',
        goalType: GoalType.values.firstWhere((type) => type.toString() == map['goalType']),
        completionDate: DateTime.parse(map['completionDate']),
        isCompleted: map['isCompleted'],
        creationDate: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      );
  }

}

