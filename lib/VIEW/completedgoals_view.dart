import 'package:final_project/MODEL/careergoals_model.dart';
import 'package:final_project/PRESENTER/careergoals_presenter.dart';
import 'package:final_project/VIEW/uncompletedgoals_view.dart';
import 'package:flutter/material.dart';

class CompletedGoalsPage extends StatefulWidget {
  const CompletedGoalsPage({Key? key}) : super(key: key);
  @override
  _CompletedGoalsPageState createState() => _CompletedGoalsPageState();
}

class _CompletedGoalsPageState extends State<CompletedGoalsPage> {
  final presenter = CareerGoalsPresenter();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder<List<CareerGoal>>(
                stream: presenter.getCareerGoals(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }else if(snapshot.hasError){
                    return Text('Error: ${snapshot.error}');
                  }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                    return Center(child: Text('No entries yet!'));
                  }
                  List<CareerGoal> goals = snapshot.data!.where((goal) => goal.isCompleted).toList();
                  return ListView.builder(
                      itemCount: goals.length,
                      itemBuilder: (context, index){
                        CareerGoal goal = goals[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:Colors.greenAccent.shade100,
                            borderRadius:BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Text(goal.goal, style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Type: ${goal.goalType == GoalType.shortTerm ? 'Short-Term' : 'Long-Term'}'),
                                Text('Completed on: ${goal.completionDate.toString()}'),
                              ],

                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red.shade800,
                                onPressed: () async {
                                  bool? confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text('Confirm Goal Deletion'),
                                        content: Text('Are you sure you want to delete this goal?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: (){
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete'),
                                            onPressed: (){
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if(confirm == true){
                                    await presenter.deleteGoal(goal.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Entry deleted!')),
                                    );
                                  }
                                }
                            ),
                          ),
                        );
                      }
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: (){
                String input = '';
                GoalType selectedType = GoalType.shortTerm;
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                          title: Text('Add Career Goal'),
                          content:Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                onChanged: (value){
                                  input = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter your goal',
                                ),
                              ),
                              SizedBox(height: 10),
                              DropdownButton<GoalType>(
                                  value: selectedType,
                                  items: GoalType.values.map((GoalType type) {
                                    return DropdownMenuItem<GoalType>(
                                      value: type,
                                      child: Text(type == GoalType.shortTerm ? 'Short-Term' : 'Long-Term'),
                                    );
                                  }).toList(),
                                  onChanged: (GoalType? newValue){
                                    if(newValue != null){
                                      setState(() {
                                        selectedType = newValue;
                                      });
                                    }
                                  }
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              child: Text('Save'),
                              onPressed: (){
                                if(input.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Goal cannot be empty!')),
                                  );
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Goal added!')),
                                );
                                presenter.addCareerGoal(
                                    CareerGoal(
                                        id: '',
                                        goal: input,
                                        goalType: selectedType,
                                        creationDate: DateTime.now(),
                                        isCompleted: false,
                                        completionDate: null
                                    )
                                );
                                Navigator.of(context).pop();
                              },
                            )
                          ]
                      );
                    }
                );
              },
              child: Text("Add Goal"),
            ),
          ],
        ),
      ),
    );
  }
}