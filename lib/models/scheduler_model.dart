final String TABLE_SCHEDULER = 'table_schedule';
final String COL_PLACE_ID = 'place_id';
final String COL_PLACE_TITLE = 'place_title';
final String COL_PLACE_DESCRIPTION = 'place_description';
final String COL_START_TIME = 'start_time';
final String COL_END_TIME = 'end_time';

class SchedulerModel {
  int? id;
  String? title;
  String? description;
  double? startTime;
  double? endTime;

  SchedulerModel(
      {this.id, this.title, this.description, this.startTime, this.endTime});

  SchedulerModel.fromMap(Map<String, dynamic> map) {
    id = map[COL_PLACE_ID];
    title = map[COL_PLACE_TITLE];
    description = map[COL_PLACE_DESCRIPTION];
    startTime = map[COL_START_TIME];
    endTime = map[COL_END_TIME];
  }

  Map<String, dynamic> toMap() {
    var scheduleMap = <String, dynamic>{
      COL_PLACE_ID: id,
      COL_PLACE_TITLE: title,
      COL_PLACE_DESCRIPTION: description,
      COL_START_TIME: startTime,
      COL_END_TIME: endTime
    };
    if (id != null) {
      scheduleMap[COL_PLACE_ID] = id;
    }
    return scheduleMap;
  }

  @override
  String toString() {
    return 'SchedulerModel{id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime}';
  }
}
