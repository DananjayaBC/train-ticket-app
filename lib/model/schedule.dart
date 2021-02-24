import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedules {
  @JsonKey(name: "trainID")
  int trainID;

  @JsonKey(name: "startStationName")
  String startStationName;

  @JsonKey(name: "endStationName")
  String endStationName;

  @JsonKey(name: "finalStationName")
  String finalStationName;

  Schedules();

  factory Schedules.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
