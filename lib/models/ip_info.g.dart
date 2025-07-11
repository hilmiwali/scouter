// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IPInfo _$IPInfoFromJson(Map<String, dynamic> json) => IPInfo(
      ip: json['ip'] as String,
      country: json['country'] as String?,
      city: json['city'] as String?,
      isp: json['isp'] as String?,
      openPorts: (json['openPorts'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isBlacklisted: json['isBlacklisted'] as bool,
      organization: json['organization'] as String?,
    );

Map<String, dynamic> _$IPInfoToJson(IPInfo instance) => <String, dynamic>{
      'ip': instance.ip,
      'country': instance.country,
      'city': instance.city,
      'isp': instance.isp,
      'openPorts': instance.openPorts,
      'isBlacklisted': instance.isBlacklisted,
      'organization': instance.organization,
    };
