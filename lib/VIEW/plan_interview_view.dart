import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
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
  CalendarFormat _calendarFormat = CalendarFormat.month;
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

  void _showAddInterviewSheet() {
    String title = '';
    TimeOfDay selectedTime = TimeOfDay.now();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final theme = Theme.of(context);
        return Padding(
          padding: MediaQuery.of(context).viewInsets.add(EdgeInsets.all(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Schedule Interview', style: theme.textTheme.titleLarge),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (v) => title = v,
              ),
              SizedBox(height: 8),
              ListTile(
                title: Text('Time: ${selectedTime.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (t != null) {
                    selectedTime = t;
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (_selectedDay != null && title.isNotEmpty) {
                    final dateTime = DateTime(
                      _selectedDay!.year,
                      _selectedDay!.month,
                      _selectedDay!.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    _presenter.addInterview(title, dateTime);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: TableCalendar<Interview>(
                firstDay: DateTime.now().subtract(Duration(days: 365)),
                lastDay: DateTime.now().add(Duration(days: 365)),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
                eventLoader: _getEventsForDay,
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                onFormatChanged: (format) {
                  setState(() => _calendarFormat = format);
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  formatButtonDecoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  formatButtonTextStyle: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.primary),
                  titleCentered: true,
                  titleTextStyle: theme.textTheme.titleLarge!
                      .copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                  leftChevronIcon:
                  Icon(Icons.chevron_left, color: theme.colorScheme.primary),
                  rightChevronIcon:
                  Icon(Icons.chevron_right, color: theme.colorScheme.primary),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, interviews) {
                    if (interviews.isNotEmpty) {
                      return Positioned(
                        right: 1,
                        bottom: 1,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${interviews.length}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                events.isEmpty
                    ? 'No interviews'
                    : '${events.length} interview(s)',
                key: ValueKey(events.length),
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Divider(height: 32),
            Expanded(
              child: events.isEmpty
                  ? Center(child: Text('Select a date to see interviews'))
                  : ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, idx) {
                  final iv = events[idx];
                  return Dismissible(
                    key: ValueKey(iv.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: theme.colorScheme.error,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => _presenter.deleteInterview(iv.id),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(iv.title),
                        subtitle: Text(DateFormat.jm().format(iv.dateTime)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: _showAddInterviewSheet,
      ),
    );
  }
}
