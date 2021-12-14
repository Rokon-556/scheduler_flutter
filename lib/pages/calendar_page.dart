import 'package:flutter/material.dart';
import 'package:flutter_calender/helpers/db_helper.dart';
import 'package:flutter_calender/models/scheduler_model.dart';
import 'package:flutter_calender/pages/add_time_page.dart';
import 'package:flutter_calender/pages/scheduler_page.dart';
import 'package:flutter_calender/widgets/schedule_item.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<SchedulerModel> scheduleList = [];
  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  getScheduleList() {
    DBHelper.getSchedule().then((sList) {
      setState(() {
        scheduleList = sList;
        print('scheduleList');
        print(scheduleList);
      });
    });
  }

  @override
  void initState() {
    getScheduleList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDay,
            daysOfWeekVisible: true,
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(
                () {
                  format = _format;
                },
              );
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                _selectedDay = selectDay;
                _focusedDay = focusDay;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddTimePage()));
              });
              print(focusDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(_focusedDay, date);
            },
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ScheduleItem(scheduleList[index]);
              },
              itemCount: scheduleList.length,
            ),
          )
        ],
      ),
    );
  }
}
