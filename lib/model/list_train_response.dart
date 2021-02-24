import 'package:json_annotation/json_annotation.dart';
import 'package:train_ticket_app/model/schedule.dart';

part 'list_train_response.g.dart';

@JsonSerializable()
class ListTrainResponse {
  ListTrainResponse();

  @JsonKey(name: "SUCCESS")
  bool success;

  @JsonKey(name: "MESSAGE")
  String massage;

  @JsonKey(name: "QUERY")
  Map<String, dynamic> QUERY;

  @JsonKey(name: "NOFRESULTS")
  int noresult;

  @JsonKey(name: "RESULTS")
  Map<String, dynamic> RESULTS;

  @JsonKey(name: "directTrains")
  String directtrains;

  @JsonKey(name: "trainsList")
  List<Schedules> schedule;

  factory ListTrainResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTrainResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListTrainResponseToJson(this);
}
