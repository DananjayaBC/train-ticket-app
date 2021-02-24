// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedules _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedules()
    ..trainID = json['trainID'] as int
    ..startStationName = json['startStationName'] as String
    ..endStationName = json['endStationName'] as String
    ..finalStationName = json['finalStationName'] as String;

}

Map<String, dynamic> _$ScheduleToJson(Schedules instance) => <String, dynamic>{
      'trainID': instance.trainID,
      'startStationName': instance.startStationName,
      'endStationName': instance.endStationName,
      'finalStationName': instance.finalStationName,

};
