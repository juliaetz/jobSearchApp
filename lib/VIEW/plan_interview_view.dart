import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:final_project/PRESENTER/careergoals_presenter.dart';
import 'package:final_project/MODEL/careergoals_model.dart';

class PlanInterviewPage extends StatefulWidget {
  @override
  _PlanInterviewPageState createState() => _PlanInterviewPageState();
}

class _PlanInterviewPageState extends State<PlanInterviewPage> {
  final CareerGoalsPresenter _presenter = CareerGoalsPresenter();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Interview>> _events = {};

  @override
  void initState() {
    super.initState();
    _presenter.getInterviews().listen((list) {
      final mapped = <DateTime, List<Interview>>{};
      for (var iv in list) {
        final day = DateTime(iv.dateTime.year, iv.dateTime.month, iv.dateTime.day);
        mapped.putIfAbsent(day, () => []).add(iv);
      }
      setState(() => _events = mapped);
    });
  }

  List<Interview> _getEventsForDay(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return _events[d] ?? [];
  }

  Future<void> _addInterview() async {
    if (_selectedDay == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final dateTime = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      time.hour,
      time.minute,
    );

    // Simple title prompt:
    final title = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Interview Title'),
        content: TextField(
          onSubmitted: Navigator.of(context).pop,
          decoration: InputDecoration(hintText: 'e.g. Google Phone Screen'),
        ),
      ),
    );
    if (title != null && title.isNotEmpty) {
      await _presenter.addInterview(title, dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Interview>(
          firstDay: DateTime.now().subtract(Duration(days: 365)),
          lastDay: DateTime.now().add(Duration(days: 365)),
          focusedDay: _focusedDay,
          eventLoader: _getEventsForDay,
          selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
          onDaySelected: (selected, focused) {
            setState(() {
              _selectedDay = selected;
              _focusedDay = focused;
            });
          },
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Schedule Interview'),
          onPressed: _addInterview,
        ),
        const Divider(),
        Expanded(
          child: ListView(
            children: _getEventsForDay(_selectedDay ?? _focusedDay)
                .map((iv) => ListTile(
              title: Text(iv.title),
              subtitle: Text(
                  '${iv.dateTime.hour.toString().padLeft(2, '0')}:${iv.dateTime.minute.toString().padLeft(2, '0')}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () =>
                    _presenter.deleteInterview(iv.id),
              ),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
