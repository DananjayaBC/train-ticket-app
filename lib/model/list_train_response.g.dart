// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_train_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListTrainResponse _$ListTrainResponseFromJson(Map<String, dynamic> json) {
  return ListTrainResponse()
    ..success = json['SUCCESS'] as bool
    ..massage = json['MESSAGE'] as String
    ..QUERY = json['QUERY'] as Map<String, dynamic>
    ..noresult = json['NOFRESULTS'] as int
    ..RESULTS = json['RESULTS'] as Map<String, dynamic>
    ..directtrains = json['directTrains'] as String
    ..schedule = (json['trainsList'] as List)
        ?.map((e) =>
            e == null ? null : Schedules.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ListTrainResponseToJson(ListTrainResponse instance) =>
    <String, dynamic>{
      'SUCCESS': instance.success,
      'MESSAGE': instance.massage,
      'QUERY': instance.QUERY,
      'NOFRESULTS': instance.noresult,
      'RESULTS': instance.RESULTS,
      'directTrains': instance.directtrains,
      'trainsList': instance.schedule,
    };
