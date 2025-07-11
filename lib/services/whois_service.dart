import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WhoisService {
  static final String _apiKey = dotenv.env['WHOIS_API_KEY'] ?? '';
  static final String _baseUrl = dotenv.env['WHOIS_BASE_URL'] ?? '';

  static Future<Map<String, dynamic>> getDomainInfo(String domain) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$domain'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch domain info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching domain info: $e');
    }
  }
}
