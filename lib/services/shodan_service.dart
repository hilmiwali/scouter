import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/ip_info.dart';

class ShodanService {
  static final String _apiKey = dotenv.env['SHODAN_API_KEY'] ?? '';
  static final String _baseUrl = dotenv.env['SHODAN_BASE_URL'] ?? '';

  static Future<IPInfo?> getIPInfo(String ip) async {
    if (_apiKey.isEmpty) {
      throw Exception('Shodan API key not configured');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/shodan/host/$ip?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return IPInfo(
          ip: ip,
          country: data['country_name'],
          city: data['city'],
          isp: data['isp'],
          openPorts: List<int>.from(data['ports'] ?? []),
          isBlacklisted: data['tags']?.contains('malware') ?? false,
          organization: data['org'],
        );
      } else {
        throw Exception('Failed to fetch IP info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching IP info: $e');
    }
  }
}
