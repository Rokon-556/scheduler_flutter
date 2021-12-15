import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_calender/pages/add_time_page.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({Key? key}) : super(key: key);

  @override
  _SchedulerPageState createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  @override
  Widget build(BuildContext context) {
    //DateTime now = DateTime.now();
    //DateTime date = DateTime(now.year, now.month, now.day);

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Schedule'),
      ),
      body: CalendarControllerProvider(
        controller: EventController(),
        child: DayView(
//controller: EventController(),
          eventTileBuilder: (date, events, boundary, start, end) {
            return Container();
          },
          showVerticalLine: true,
          showLiveTimeLineInAllDays: true,
          heightPerMinute: 1,

          eventArranger: SideEventArranger(),
          onEventTap: (events, date) => print(events),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTimePage()));
        },
        backgroundColor: Colors.lightBlue,
        child: Center(
          child: Text(
            '  Add Events',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
