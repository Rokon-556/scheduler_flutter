import 'package:flutter/material.dart';
import 'package:flutter_calender/helpers/db_helper.dart';
import 'package:flutter_calender/models/scheduler_model.dart';
import 'package:flutter_calender/pages/calendar_page.dart';
import 'package:flutter_calender/pages/scheduler_page.dart';

class AddTimePage extends StatefulWidget {
  int? scheduleID;


   AddTimePage({Key? key,this.scheduleID}) : super(key: key);

  @override
  _AddTimePageState createState() => _AddTimePageState();
}

class _AddTimePageState extends State<AddTimePage> {

  final _formKey = GlobalKey<FormState>();
  List<SchedulerModel>scheduleList=[];
  final schedule=SchedulerModel();

  TextEditingController? _titleController,
      _descriptionController,
      _startController,
      _endController;
  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _startController = TextEditingController();
    _endController = TextEditingController();

    if(widget.scheduleID!=null){
     DBHelper.getScheduleByID(widget.scheduleID!).then((model){
      print(widget.scheduleID);
      _titleController?.text=model!.title.toString();
      _descriptionController?.text=model!.description.toString();
      _startController?.text=model!.startTime.toString();
      _endController?.text=model!.endTime.toString();
     });
    }

    super.initState();

  }

  void _saveSchedule(){
    _formKey.currentState!.save();
    Future <int> id=DBHelper.insertSchedule(TABLE_SCHEDULER,schedule.toMap());
    id.then((id){
      if(id>0){
        print('Saved');
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SchedulerPage()));
      }else{
        print('Not Saved');
      }
    });
    print(schedule);
  }
  void _updateSchedule(){
    _formKey.currentState!.save();
    schedule.id=widget.scheduleID;
    DBHelper.updateSchedule(schedule).then((value){
      if(value>0){
        print('Update');
        Navigator.of(context).pop();
      }else{
        print('could not updated');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time & Place'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onSaved: (value){
                  schedule.title=value;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onSaved: (value){
                  schedule.description=value;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _startController,
                decoration: InputDecoration(
                  hintText: 'Enter Starting Time',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onSaved: (value){
                  schedule.startTime=double.parse('$value');
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _endController,
                decoration: InputDecoration(
                  hintText: 'Enter Ending Time',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onSaved: (value){
                  schedule.endTime=double.parse('$value');
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if(widget.scheduleID==null){
                    _saveSchedule();
                  }else{
                    _updateSchedule();
                  }
                },
                child: Text(widget.scheduleID==null?'Save':'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
