import 'package:final_project/MODEL/careergoals_model.dart';
import 'package:final_project/PRESENTER/careergoals_presenter.dart';
import 'package:final_project/VIEW/careergoals_view.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Career Goals"),
      ),
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
                                onPressed: (){
                                  presenter.deleteGoal(goal.id);
                                },
                                icon: Icon(Icons.delete, color: Colors.red.shade800,),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if(index == 0){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => CareerGoalsPage()));
          }
          if(index == 1){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedGoalsPage()));
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Career Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Completed Goals',
          ),
        ],
      ),
    );
  }
}