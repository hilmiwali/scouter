// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookup_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookupResult _$LookupResultFromJson(Map<String, dynamic> json) => LookupResult(
      query: json['query'] as String,
      type: json['type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'] as Map<String, dynamic>,
      riskScore: (json['riskScore'] as num).toInt(),
      findings:
          (json['findings'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LookupResultToJson(LookupResult instance) =>
    <String, dynamic>{
      'query': instance.query,
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
      'data': instance.data,
      'riskScore': instance.riskScore,
      'findings': instance.findings,
    };
