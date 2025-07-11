import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lookup_result.g.dart';

@JsonSerializable()
class LookupResult {
  final String query;
  final String type;
  final DateTime timestamp;
  final Map<String, dynamic> data;
  final int riskScore;
  final List<String> findings;

  LookupResult({
    required this.query,
    required this.type,
    required this.timestamp,
    required this.data,
    required this.riskScore,
    required this.findings,
  });

  factory LookupResult.fromJson(Map<String, dynamic> json) =>
      _$LookupResultFromJson(json);

  Map<String, dynamic> toJson() => _$LookupResultToJson(this);

  String get riskLevel {
    if (riskScore >= 80) return 'High';
    if (riskScore >= 50) return 'Medium';
    if (riskScore >= 20) return 'Low';
    return 'Minimal';
  }

  Color get riskColor {
    switch (riskLevel) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }
}
