import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HIBPService {
  static final String _apiKey = dotenv.env['HIBP_API_KEY'] ?? '';
  static final String _baseUrl = dotenv.env['HIBP_BASE_URL'] ?? '';

  static Future<List<String>> checkEmailBreaches(String email) async {
    if (_apiKey.isEmpty) {
      throw Exception('HIBP API key not configured');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/breachedaccount/$email'),
        headers: {
          'hibp-api-key': _apiKey,
          'User-Agent': 'OSINT-Toolkit-App',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> breaches = json.decode(response.body);
        return breaches.map((breach) => breach['Name'].toString()).toList();
      } else if (response.statusCode == 404) {
        return []; // No breaches found
      } else {
        throw Exception('Failed to check breaches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error checking email breaches: $e');
    }
  }
}
