import 'package:json_annotation/json_annotation.dart';

part 'ip_info.g.dart';

@JsonSerializable()
class IPInfo {
  final String ip;
  final String? country;
  final String? city;
  final String? isp;
  final List<int>? openPorts;
  final bool isBlacklisted;
  final String? organization;

  IPInfo({
    required this.ip,
    this.country,
    this.city,
    this.isp,
    this.openPorts,
    required this.isBlacklisted,
    this.organization,
  });

  factory IPInfo.fromJson(Map<String, dynamic> json) =>
      _$IPInfoFromJson(json);

  Map<String, dynamic> toJson() => _$IPInfoToJson(this);
}
